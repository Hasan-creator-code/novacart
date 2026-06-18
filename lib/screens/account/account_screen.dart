import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      body: const SafeArea(
        child: Center(
          child: Text(
            'Account — coming soon',
            style: TextStyle(fontSize: 18, color: AppColors.textHigh),
          ),
        ),
      ),
    );
  }
}
