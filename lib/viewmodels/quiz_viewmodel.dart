import 'package:flutter/foundation.dart';

import '../core/utils/enums.dart';
import '../data/models/quiz_question_model.dart';
import '../data/repositories/quiz_repository.dart';

/// Drives the data-driven quiz. The View never hardcodes options -
/// it iterates [question.options] and reacts to [answerState].
class QuizViewModel extends ChangeNotifier {
  QuizViewModel({QuizRepository? repository})
      : _repository = repository ?? QuizRepository();

  final QuizRepository _repository;

  QuizQuestionModel? _question;
  QuizQuestionModel? get question => _question;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _selectedOption;
  String? get selectedOption => _selectedOption;

  QuizAnswerState _answerState = QuizAnswerState.unanswered;
  QuizAnswerState get answerState => _answerState;

  Future<void> loadQuiz() async {
    _isLoading = true;
    notifyListeners();

    _question = await _repository.fetchQuiz();

    _isLoading = false;
    notifyListeners();
  }

  void selectAnswer(String option) {
    if (_answerState == QuizAnswerState.correct) return;
    if (_question == null) return;

    _selectedOption = option;
    _answerState = option == _question!.answer
        ? QuizAnswerState.correct
        : QuizAnswerState.incorrect;

    notifyListeners();
  }

  /// Called by the View once the "shake" animation for a wrong answer
  /// finishes, so the options become tappable again.
  void clearIncorrectSelection() {
    if (_answerState == QuizAnswerState.incorrect) {
      _answerState = QuizAnswerState.unanswered;
      _selectedOption = null;
      notifyListeners();
    }
  }
}
