import 'package:flutter/material.dart';
import 'package:interactive_form/core/theme/app_theme.dart';
import 'package:interactive_form/features/login/presentation/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      home: const LoginScreen(),
    );
  }
}
