import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../state/cart_state.dart';
import '../../widgets/product_quantity_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    // Listen for cart changes, and redraw this screen when they happen.
    cartState.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    cartState.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final items = cartState.items;

    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: AppColors.backgroundBase,
        foregroundColor: AppColors.textHigh,
        elevation: 0,
      ),
      body: SafeArea(
        child: items.isEmpty
            ? const Center(
                child: Text(
                  'Your cart is empty',
                  style: TextStyle(fontSize: 18, color: AppColors.textHigh),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.glassPanelFill,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.glassBorder),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.productName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColors.textHigh,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${item.quantity} ${item.unit.label}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textMedium,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: AppColors.amber,
                          ),
                          onPressed: () {
                            setState(() {
                              cartState.removeItem(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
