import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// All text in the app routes through here so the Montserrat family
/// and the colour palette stay consistent and easy to tweak.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle get appBarTitle => GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get sectionLabel => GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.1,
        color: AppColors.textSecondary,
      );

  static TextStyle get storyText => GoogleFonts.montserrat(
        fontSize: 15,
        height: 1.55,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  static TextStyle get questionText => GoogleFonts.montserrat(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get optionText => GoogleFonts.montserrat(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get buttonLabel => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
        color: AppColors.onAccent,
      );

  static TextStyle get statusText => GoogleFonts.montserrat(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );

  static TextStyle get caption => GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );
}
