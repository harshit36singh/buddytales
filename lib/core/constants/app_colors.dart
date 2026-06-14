import 'package:flutter/material.dart';

/// Colour palette lifted directly from the Peblo "Giggle Learn"
/// reference screens - sunny yellow + orange backgrounds, cream
/// cards, a blue accent (as used on the "ABC Adventure" pill) and
/// a red/coral accent (as used on "Login" / "Let's play" buttons).
///
/// No other colours are introduced anywhere in the app.
class AppColors {
  AppColors._();

  /// Sunny yellow - main scaffold background.
  static const Color scaffoldBackground = Color(0xFFFFC93C);

  /// Warm orange - used for the Buddy's head / hero accents.
  static const Color heroOrange = Color(0xFFF2994A);

  /// Soft cream - card surfaces (story card, quiz card, buddy frame).
  static const Color cardCream = Color(0xFFFFF7E9);

  /// Blue accent - correct answers / positive state.
  static const Color accentBlue = Color(0xFF3D5AFE);

  /// Red / coral accent - primary call-to-action buttons.
  static const Color accentRed = Color(0xFFF2562D);

  /// Primary text colour (warm dark brown, matches reference text).
  static const Color textPrimary = Color(0xFF4A2E1A);

  /// Secondary / muted text colour.
  static const Color textSecondary = Color(0xFF9C8775);

  /// Text drawn on top of solid accent-coloured buttons.
  static const Color onAccent = Color(0xFFFFF7E9);

  /// Default fill for an unselected quiz option.
  static const Color optionFill = Color(0xFFFFFFFF);

  /// Default border for a quiz option / outline accents.
  static const Color optionBorder = Color(0xFFF0E3CF);
}
