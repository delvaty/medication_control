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

  @override
  void initState() {
    super.initState();
    checkOnboardingStatus();
  }

  Future<void> checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
    if (onboardingComplete) {
      setState(() {
        _showOnboarding = !onboardingComplete;
      });
    }
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
    setState(() {
      _showOnboarding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _showOnboarding ? OnboardingScreen(onComplete: completeOnboarding) : HomeScreen(),
    );
  }
}
