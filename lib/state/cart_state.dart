import 'package:flutter/material.dart';
import '../widgets/product_quantity_card.dart';

// One item sitting in the cart.
class CartItem {
  final String productName;
  final String quantity;
  final ProductUnit unit;

  CartItem({
    required this.productName,
    required this.quantity,
    required this.unit,
  });
}

// The shared cart "memory" — every screen in the app can read and update this.
class CartState extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(String productName, String quantity, ProductUnit unit) {
    _items.add(
      CartItem(productName: productName, quantity: quantity, unit: unit),
    );
    notifyListeners(); // tells every screen watching this "something changed, redraw yourself"
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  int get itemCount => _items.length;
}

// A single shared instance every screen will use.
final cartState = CartState();
