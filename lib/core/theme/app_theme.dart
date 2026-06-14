import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

/// Minimal, flat theme - no shadows/elevation, no hover/glow effects.
/// Montserrat is applied app-wide via [GoogleFonts.montserratTextTheme].
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData.light();

    return base.copyWith(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      textTheme: GoogleFonts.montserratTextTheme(base.textTheme),
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.accentRed,
        secondary: AppColors.accentBlue,
        surface: AppColors.cardCream,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
