import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/enums.dart';
import '../../viewmodels/quiz_viewmodel.dart';
import 'quiz_option_tile.dart';

/// The interactive quiz card.
///
/// Genuinely data-driven: it iterates `question.options` and builds one
/// [QuizOptionTile] per entry. The JSON payload in [QuizRepository] can
/// be swapped for 3, 4 or 5 options, or completely different wording,
/// with zero changes to this widget.
///
/// Also owns the "shake on wrong answer" animation + haptic feedback,
/// driven by [QuizViewModel.answerState].
class QuizCard extends StatefulWidget {
  const QuizCard({super.key});

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> with SingleTickerProviderStateMixin {
  late final AnimationController _shakeController;
  late QuizViewModel _quizViewModel;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _quizViewModel = context.read<QuizViewModel>();
    _quizViewModel.addListener(_onQuizChanged);
  }

  void _onQuizChanged() {
    if (_quizViewModel.answerState == QuizAnswerState.incorrect) {
      HapticFeedback.mediumImpact();
      _shakeController.forward(from: 0).whenComplete(() {
        if (mounted) _quizViewModel.clearIncorrectSelection();
      });
    }
  }

  @override
  void dispose() {
    _quizViewModel.removeListener(_onQuizChanged);
    _shakeController.dispose();
    super.dispose();
  }

  /// Decaying sine wave - a quick shake that settles back to centre.
  double _shakeOffset(double t) {
    const amplitude = 12.0;
    return amplitude * math.sin(t * math.pi * 6) * (1 - t);
  }

  @override
  Widget build(BuildContext context) {
    final quizViewModel = context.watch<QuizViewModel>();
    final question = quizViewModel.question;

    if (quizViewModel.isLoading || question == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 28),
        child: Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(strokeWidth: 2.4, color: AppColors.accentBlue),
          ),
        ),
      );
    }

    final isCorrect = quizViewModel.answerState == QuizAnswerState.correct;
    final isIncorrect = quizViewModel.answerState == QuizAnswerState.incorrect;

    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeOffset(_shakeController.value), 0),
          child: child,
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.cardCream,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.quizLabel.toUpperCase(), style: AppTextStyles.sectionLabel),
            const SizedBox(height: 8),
            Text(question.question, style: AppTextStyles.questionText),
            const SizedBox(height: 16),

            // --- Data-driven rendering: one tile per option ---
            ...question.options.map(
              (option) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: QuizOptionTile(
                  label: option,
                  isSelected: quizViewModel.selectedOption == option,
                  isCorrectAnswer: option == question.answer,
                  answerState: quizViewModel.answerState,
                  onTap: () => quizViewModel.selectAnswer(option),
                ),
              ),
            ),

            if (isIncorrect) ...[
              const SizedBox(height: 4),
              Text(
                AppStrings.tryAgainHint,
                style: AppTextStyles.caption.copyWith(color: AppColors.accentRed),
              ),
            ],

            if (isCorrect) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.check_circle_rounded, color: AppColors.accentBlue, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    AppStrings.successTitle,
                    style: AppTextStyles.optionText.copyWith(color: AppColors.accentBlue),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(AppStrings.successSubtitle, style: AppTextStyles.caption),
            ],
          ],
        ),
      ),
    );
  }
}
