import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      body: const SafeArea(
        child: Center(
          child: Text(
            'Browse — coming soon',
            style: TextStyle(fontSize: 18, color: AppColors.textHigh),
          ),
        ),
      ),
    );
  }
}
