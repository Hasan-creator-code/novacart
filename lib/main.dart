import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NovaCart',
      theme: AppTheme.lightTheme,
      home: const NovaCartHome(),
    );
  }
}

class NovaCartHome extends StatelessWidget {
  const NovaCartHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NovaCart')),
      body: const Center(
        child: Text(
          'Hello NovaCart! 🛒',
          style: TextStyle(
            fontSize: 24,
            color: AppColors.emerald,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
