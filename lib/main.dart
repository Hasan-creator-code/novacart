import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'main_shell.dart';

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
      home: const MainShell(),
    );
  }
}
