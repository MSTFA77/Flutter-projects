import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedBackdrop extends StatelessWidget {
  const AnimatedBackdrop({super.key, required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final wave = Curves.easeInOut.transform(animation.value);
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF05060A), Color(0xFF0E0F1E)],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -120 + (60 * wave),
                left: -40,
                child: const BlurredOrb(
                  size: 260,
                  colors: [Color(0xFF7C4DFF), Color(0xFF512DA8)],
                  opacity: 0.45,
                ),
              ),
              Positioned(
                bottom: -140 + (80 * (1 - wave)),
                right: -20,
                child: const BlurredOrb(
                  size: 300,
                  colors: [Color.fromARGB(255, 178, 178, 178), Color.fromARGB(255, 46, 45, 45)]
                  ,
                  opacity: 0.35,
                ),
              ),
              Positioned(
                top: 140 + 20 * sin(animation.value * pi * 2),
                right: 60,
                child: const BlurredOrb(
                  size: 120,
                  colors: [Color(0xFF00C6FF), Color(0xFF0072FF)]
                  ,
                  opacity: 0.5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BlurredOrb extends StatelessWidget {
  const BlurredOrb({
    super.key,
    required this.size,
    required this.colors,
    this.opacity = 0.4,
  });

  final double size;
  final List<Color> colors;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: colors),
        ),
      ),
    );
  }
}
