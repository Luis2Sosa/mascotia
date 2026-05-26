import 'package:flutter/material.dart';
import 'package:mascotia/core/theme/app_theme.dart';
import 'package:mascotia/screens/auth/welcome_screen.dart';

void main() => runApp(const MascotiaApp());

class MascotiaApp extends StatelessWidget {
  const MascotiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mascotia',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const WelcomeScreen(),
    );
  }
}