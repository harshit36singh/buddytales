import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// Simple geometric placeholder for the AI Buddy character.
///
/// Kept deliberately minimal (flat shapes, no images, no shadows) -
/// swap this widget's body for a real illustration/Lottie asset
/// without touching any other file. [isHappy] switches the face to a
/// celebratory expression when the quiz is answered correctly.
class BuddyCharacter extends StatelessWidget {
  const BuddyCharacter({super.key, required this.isHappy});

  final bool isHappy;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.cardCream,
        borderRadius: BorderRadius.circular(24),
      ),
      alignment: Alignment.center,
      child: SizedBox(
        width: 120,
        height: 130,
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            // Antenna
            Positioned(
              top: 0,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.accentBlue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Head
            Positioned(
              top: 14,
              child: Container(
                width: 110,
                height: 100,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: AppColors.heroOrange,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _Eye(isHappy: isHappy),
                        const SizedBox(width: 18),
                        _Eye(isHappy: isHappy),
                      ],
                    ),
                    _Mouth(isHappy: isHappy),
                  ],
                ),
              ),
            ),
            // Blush cheeks - only shown in the happy state.
            if (isHappy) ...[
              const Positioned(
                left: 4,
                top: 64,
                child: _Cheek(),
              ),
              const Positioned(
                right: 4,
                top: 64,
                child: _Cheek(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Eye extends StatelessWidget {
  const _Eye({required this.isHappy});

  final bool isHappy;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: isHappy ? 8 : 10,
        height: isHappy ? 8 : 10,
        decoration: const BoxDecoration(
          color: AppColors.textPrimary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _Mouth extends StatelessWidget {
  const _Mouth({required this.isHappy});

  final bool isHappy;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: isHappy ? 42 : 26,
      height: isHappy ? 16 : 8,
      decoration: BoxDecoration(
        color: AppColors.textPrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: const Radius.circular(20),
          bottomRight: const Radius.circular(20),
          topLeft: Radius.circular(isHappy ? 2 : 8),
          topRight: Radius.circular(isHappy ? 2 : 8),
        ),
      ),
    );
  }
}

class _Cheek extends StatelessWidget {
  const _Cheek();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 8,
      decoration: BoxDecoration(
        color: AppColors.accentRed.withOpacity(0.35),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
