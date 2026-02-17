import 'package:flutter/material.dart';
import 'features/onboarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SFPro',
        scaffoldBackgroundColor: const Color(0xFF0B0F2F),
      ),
      home: const OnboardingScreen(),
    );
  }
}