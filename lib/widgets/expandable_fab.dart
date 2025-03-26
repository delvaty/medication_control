// lib/widgets/expandable_fab.dart
import 'package:flutter/material.dart';
import '../controllers/home_controller.dart';
import 'package:line_icons/line_icons.dart';

class ExpandableFAB extends StatelessWidget {
  final HomeController controller;
  final Function() onAddMedicinePressed;
  final Function() onAddDosePressed;

  const ExpandableFAB({
    super.key,
    required this.controller,
    required this.onAddMedicinePressed,
    required this.onAddDosePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Botón "Agregar medicamento"
        AnimatedBuilder(
          animation: controller.animationController,
          builder: (context, child) {
            return Positioned(
              right: 0,
              bottom: controller.animation2.value,
              child: Opacity(
                opacity: controller.fadeAnimation.value,
                child: controller.isExpanded
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.greenAccent.shade100,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Text(
                                  "Añadir dosis",
                                  style: TextStyle(
                                      color: Colors.green.shade700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                          Transform.scale(
                            scale: controller.scaleAnimation.value,
                            child: FloatingActionButton(
                              heroTag: 'Add_user',
                              onPressed: onAddDosePressed,
                              backgroundColor: Colors.green,
                              shape: const CircleBorder(),
                              child: const Icon(LineIcons.capsules, color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            );
          },
        ),
        // Botón "Agregar salud"
        AnimatedBuilder(
          animation: controller.animationController,
          builder: (context, child) {
            return Positioned(
              right: 0,
              bottom: controller.animation1.value,
              child: Opacity(
                opacity: controller.fadeAnimation.value,
                child: controller.isExpanded
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blueAccent.shade100,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Text(
                                  "Añadir medicina",
                                  style: TextStyle(
                                    color: Colors.blueAccent.shade700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Transform.scale(
                            scale: controller.scaleAnimation.value,
                            child: FloatingActionButton(
                              heroTag: 'add_medicine',
                              onPressed: onAddMedicinePressed,
                              backgroundColor: Colors.blueAccent,
                              shape: const CircleBorder(),
                              child: const Icon(LineIcons.medicalBook, color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            );
          },
        ),
        // Botón principal
        AnimatedBuilder(
          animation: controller.animationController,
          builder: (context, child) {
            return Positioned(
              right: 0,
              bottom: 0,
              child: Transform.rotate(
                angle: controller.rotationAnimation.value * 2 * 3.14159,
                child: Transform.scale(
                  scale: 1.0 + (controller.scaleAnimation.value - 1.0) * 0.5,
                  child: FloatingActionButton(
                    onPressed: controller.toggleMenu,
                    backgroundColor: Colors.red,
                    shape: const CircleBorder(),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      child: controller.isExpanded
                          ? const Icon(Icons.close,
                              key: ValueKey('close'),
                              color: Colors.white,
                              size: 32)
                          : const Icon(Icons.add,
                              key: ValueKey('add'),
                              color: Colors.white,
                              size: 32),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}