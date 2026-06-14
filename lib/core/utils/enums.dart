/// Lifecycle of the "Read Me a Story" narration.
///
/// idle    -> nothing playing, button shows "Read Me a Story"
/// loading -> audio is being fetched / prepared
/// playing -> narration is currently audible
/// error   -> narration failed, friendly retry shown
enum AudioPlaybackState { idle, loading, playing, error }

/// State of the currently rendered quiz question.
///
/// unanswered -> no selection yet, or a wrong pick was just cleared
/// incorrect  -> the selected option does not match the answer
/// correct    -> the selected option matches the answer (locked)
enum QuizAnswerState { unanswered, incorrect, correct }
