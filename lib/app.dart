import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/onboarding_screen.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _showOnboarding = true;
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
    if (onboardingComplete) {
      setState(() => _showOnboarding = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control de Medicamentos',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _showOnboarding ? OnboardingScreen() : HomeScreen(),
    );
  }
}
