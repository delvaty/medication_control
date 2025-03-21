// lib/controllers/home_controller.dart
import 'package:flutter/material.dart';

class HomeController {
  // Para el BottomNavigationBar
  int selectedIndex = 0;

  // Para el menú expandible FAB
  bool isExpanded = false;
  late AnimationController animationController;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;
  late Animation<double> rotationAnimation;

  void initAnimations(TickerProvider vsync) {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: vsync,
    );

    animation1 = Tween<double>(begin: 0, end: 80).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOutBack),
    );

    animation2 = Tween<double>(begin: 0, end: 160).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOutBack),
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    rotationAnimation = Tween<double>(begin: 0.0, end: 0.125).animate(
      CurvedAnimation(
          parent: animationController, curve: Curves.easeInOutBack),
    );

    scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
          reverseCurve: const Interval(0.7, 1.0, curve: Curves.easeIn)),
    );
  }

  void toggleMenu() {
    isExpanded = !isExpanded;
    if (isExpanded) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  void onItemTapped(int index) {
    selectedIndex = index;
  }

  void dispose() {
    animationController.dispose();
  }
}