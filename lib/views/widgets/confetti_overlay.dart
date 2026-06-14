import 'dart:math' as math;

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// Thin wrapper around [ConfettiWidget], coloured with the app's
/// palette only. The [controller] is owned by the screen so it can be
/// triggered from the QuizViewModel listener.
class ConfettiOverlay extends StatelessWidget {
  const ConfettiOverlay({super.key, required this.controller});

  final ConfettiController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: controller,
        blastDirection: math.pi / 2,
        emissionFrequency: 0.18,
        numberOfParticles: 16,
        gravity: 0.25,
        shouldLoop: false,
        colors: const [
          AppColors.accentRed,
          AppColors.accentBlue,
          AppColors.heroOrange,
          AppColors.scaffoldBackground,
        ],
      ),
    );
  }
}
