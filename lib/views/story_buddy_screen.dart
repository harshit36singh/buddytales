import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';
import '../core/utils/enums.dart';
import '../viewmodels/quiz_viewmodel.dart';
import '../viewmodels/story_viewmodel.dart';
import 'widgets/buddy_character.dart';
import 'widgets/confetti_overlay.dart';
import 'widgets/quiz_card.dart';
import 'widgets/read_story_button.dart';
import 'widgets/story_card.dart';

/// Single screen for the AI Story Buddy + Quiz feature.
///
/// Coordinates the two ViewModels:
/// - [StoryViewModel] drives narration; once it finishes for the
///   first time, the quiz is requested and revealed.
/// - [QuizViewModel] drives the data-driven quiz; a correct answer
///   triggers confetti and switches the Buddy to a happy expression.
class StoryBuddyScreen extends StatefulWidget {
  const StoryBuddyScreen({super.key});

  @override
  State<StoryBuddyScreen> createState() => _StoryBuddyScreenState();
}

class _StoryBuddyScreenState extends State<StoryBuddyScreen> {
  late final ConfettiController _confettiController;
  late StoryViewModel _storyViewModel;
  late QuizViewModel _quizViewModel;
  bool _quizRequested = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _storyViewModel = context.read<StoryViewModel>();
    _quizViewModel = context.read<QuizViewModel>();
    _storyViewModel.addListener(_onStoryChanged);
    _quizViewModel.addListener(_onQuizChanged);
  }

  void _onStoryChanged() {
    // As soon as narration finishes for the first time, fetch and
    // reveal the quiz.
    if (_storyViewModel.hasFinishedOnce && !_quizRequested) {
      _quizRequested = true;
      _quizViewModel.loadQuiz();
    }
  }

  void _onQuizChanged() {
    if (_quizViewModel.answerState == QuizAnswerState.correct) {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _storyViewModel.removeListener(_onStoryChanged);
    _quizViewModel.removeListener(_onQuizChanged);
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showQuiz = context.select<StoryViewModel, bool>((vm) => vm.hasFinishedOnce);
    final isBuddyHappy = context.select<QuizViewModel, bool>(
      (vm) => vm.answerState == QuizAnswerState.correct,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appTitle, style: AppTextStyles.appBarTitle),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.account_circle_outlined, color: AppColors.textPrimary),
          ),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BuddyCharacter(isHappy: isBuddyHappy),
                  const SizedBox(height: 18),
                  const StoryCard(),
                  const SizedBox(height: 18),
                  const ReadStoryButton(),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOut,
                    alignment: Alignment.topCenter,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: showQuiz
                          ? const Padding(
                              key: ValueKey('quiz-visible'),
                              padding: EdgeInsets.only(top: 18),
                              child: QuizCard(),
                            )
                          : const SizedBox.shrink(key: ValueKey('quiz-hidden')),
                    ),
                  ),
                ],
              ),
            ),
          ),
          IgnorePointer(
            child: ConfettiOverlay(controller: _confettiController),
          ),
        ],
      ),
    );
  }
}
