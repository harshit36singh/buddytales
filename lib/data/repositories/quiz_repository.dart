import '../models/quiz_question_model.dart';

/// Stands in for a real network call to the Peblo backend.
///
/// Swap [fetchQuiz]'s body for an `http` / `dio` call returning the
/// same JSON shape and nothing else in the app needs to change -
/// [QuizQuestionModel.fromJson] and the QuizCard renderer are already
/// shape-agnostic (3, 4 or 5 options, any text).
class QuizRepository {
  Future<QuizQuestionModel> fetchQuiz() async {
    // Simulated network latency so the loading state is visible.
    await Future.delayed(const Duration(milliseconds: 300));

    const json = {
      "question": "What colour was Pip the Robot's lost gear?",
      "options": ["Red", "Green", "Blue", "Yellow"],
      "answer": "Blue",
    };

    return QuizQuestionModel.fromJson(json);
  }
}
