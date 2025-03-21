import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:medication_control/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const OnboardingScreen({super.key, required this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _completeOnboarding(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
    widget.onComplete();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  /* Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assests/images/$assetName', width: width);
  } */

  Widget _buildImage(String assetName) {
    return SizedBox(
      width: double.infinity, // Usa todo el ancho disponible
      height: 400, // Altura fija más grande
      child: Image.asset(
        'assests/images/$assetName',
        fit: BoxFit.contain, // Ajusta la imagen manteniendo proporciones
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      pageColor: Color(0xFFC0F0F7),
      titleTextStyle: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Montserrat',
      ),
      bodyTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.black87,
        height: 1.5,
        fontFamily: 'Montserrat',
      ),
      imagePadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.only(top: 16, bottom: 10),
      bodyPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      imageAlignment: Alignment.center,
      imageFlex: 3,
      bodyFlex: 2,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: const Color(0xFFC0F0F7),
      allowImplicitScrolling: true,
      pages: [
        PageViewModel(
          title: "Welcome to MediAlert.",
          body: "Your health always within reach.",
          image: _buildImage('1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Find your medications in seconds.",
          body: "Quick, easy, and always at your fingertips.",
          image: _buildImage('2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Don't forget to take your medication on time.",
          body: "Stay healthy and on track with timely reminders.",
          image: _buildImage('3.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _completeOnboarding(context),
      onSkip: () => _completeOnboarding(context),
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      skip: const Text(
        'Skip',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      next: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Next',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      done: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Start',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.black26,
        activeSize: Size(22.0, 10.0),
        activeColor: Colors.black,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
