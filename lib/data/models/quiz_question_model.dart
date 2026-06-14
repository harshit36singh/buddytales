/// Mirrors the quiz JSON contract from the brief:
/// {
///   "question": "...",
///   "options": ["...", "...", ...],   // 3, 4 or 5 entries
///   "answer": "..."
/// }
///
/// The UI renders purely from this model - adding/removing entries in
/// [options] changes the number of rendered choices with zero widget
/// changes (see QuizCard).
class QuizQuestionModel {
  final String question;
  final List<String> options;
  final String answer;

  const QuizQuestionModel({
    required this.question,
    required this.options,
    required this.answer,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionModel(
      question: json['question'] as String,
      options: (json['options'] as List).map((e) => e.toString()).toList(),
      answer: json['answer'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'question': question,
        'options': options,
        'answer': answer,
      };
}
