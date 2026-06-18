import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      body: const SafeArea(
        child: Center(
          child: Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 18, color: AppColors.textHigh),
          ),
        ),
      ),
    );
  }
}
