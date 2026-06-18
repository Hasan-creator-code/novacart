import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/product_quantity_card.dart';

// One item sitting in the cart.
class CartItem {
  final String id; // Firestore document id, used for deleting
  final String productName;
  final String quantity;
  final ProductUnit unit;

  CartItem({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.unit,
  });
}

// The shared cart "memory" — every screen in the app can read and update this.
// Now backed by Firestore, so it survives app restarts and syncs per logged-in user.
class CartState extends ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;
  int get itemCount => _items.length;

  CollectionReference<Map<String, dynamic>>? get _cartCollection {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('cart');
  }

  // Call this once when the app starts (or right after login) to start listening.
  void startListening() {
    final collection = _cartCollection;
    if (collection == null) return;

    collection.snapshots().listen((snapshot) {
      _items = snapshot.docs.map((doc) {
        final data = doc.data();
        return CartItem(
          id: doc.id,
          productName: data['productName'] as String,
          quantity: data['quantity'] as String,
          unit: ProductUnit.values.firstWhere(
            (u) => u.name == data['unit'],
            orElse: () => ProductUnit.grams,
          ),
        );
      }).toList();
      notifyListeners();
    });
  }

  Future<void> addItem(
    String productName,
    String quantity,
    ProductUnit unit,
  ) async {
    final collection = _cartCollection;
    if (collection == null) return;

    await collection.add({
      'productName': productName,
      'quantity': quantity,
      'unit': unit.name,
      'addedAt': FieldValue.serverTimestamp(),
    });
    // No need to call notifyListeners() manually — the snapshots() listener above does it.
  }

  Future<void> removeItem(int index) async {
    final collection = _cartCollection;
    if (collection == null) return;
    if (index < 0 || index >= _items.length) return;

    final itemId = _items[index].id;
    await collection.doc(itemId).delete();
  }
}

// A single shared instance every screen will use.
final cartState = CartState();
