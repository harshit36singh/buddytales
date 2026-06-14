import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/enums.dart';

/// Renders one quiz option. Purely presentational - the parent
/// [QuizCard] decides how many of these to render based on the
/// data-driven `options` list, so this widget makes no assumptions
/// about option count or wording.
class QuizOptionTile extends StatelessWidget {
  const QuizOptionTile({
    super.key,
    required this.label,
    required this.isSelected,
    required this.isCorrectAnswer,
    required this.answerState,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final bool isCorrectAnswer;
  final QuizAnswerState answerState;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isLocked = answerState == QuizAnswerState.correct;

    Color borderColor = AppColors.optionBorder;
    Color fillColor = AppColors.optionFill;
    IconData? trailingIcon;
    Color trailingColor = AppColors.optionBorder;

    if (answerState == QuizAnswerState.correct && isCorrectAnswer) {
      borderColor = AppColors.accentBlue;
      fillColor = AppColors.accentBlue.withOpacity(0.08);
      trailingIcon = Icons.check_circle_rounded;
      trailingColor = AppColors.accentBlue;
    } else if (answerState == QuizAnswerState.incorrect && isSelected) {
      borderColor = AppColors.accentRed;
      fillColor = AppColors.accentRed.withOpacity(0.06);
      trailingIcon = Icons.close_rounded;
      trailingColor = AppColors.accentRed;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: isLocked ? null : onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Expanded(
                  child: Text(label, style: AppTextStyles.optionText),
                ),
                if (trailingIcon != null)
                  Icon(trailingIcon, size: 20, color: trailingColor)
                else
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.optionBorder, width: 1.4),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
