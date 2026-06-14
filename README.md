# AI Story Buddy & Quiz - Flutter (MVVM)

## Structure

```
lib/
├── main.dart                     # entry point
├── app.dart                      # MaterialApp + Provider setup
├── core/
│   ├── constants/
│   │   ├── app_colors.dart       # palette from the Giggle Learn reference only
│   │   ├── app_text_styles.dart  # Montserrat (Google Fonts) text styles
│   │   └── app_strings.dart      # all copy
│   ├── theme/app_theme.dart      # flat ThemeData, no shadows/hover
│   └── utils/enums.dart          # AudioPlaybackState, QuizAnswerState
├── data/
│   ├── models/quiz_question_model.dart
│   ├── repositories/quiz_repository.dart   # simulated backend JSON
│   └── services/
│       ├── tts_service.dart              # on-device flutter_tts wrapper
│       └── elevenlabs_tts_service.dart   # <-- ElevenLabs slot, see below
├── viewmodels/
│   ├── story_viewmodel.dart      # narration state machine
│   └── quiz_viewmodel.dart       # quiz state machine
└── views/
    ├── story_buddy_screen.dart   # composes everything, coordinates transitions
    └── widgets/
        ├── buddy_character.dart  # placeholder Buddy face (idle/happy)
        ├── story_card.dart
        ├── read_story_button.dart  # idle / loading / playing / error
        ├── quiz_card.dart           # data-driven renderer + shake animation
        ├── quiz_option_tile.dart
        └── confetti_overlay.dart
```

## Run

```
flutter pub get
flutter run
```

Montserrat is loaded via `google_fonts`, which fetches the font at
runtime on first use (and caches it). For a fully offline build, bundle
the Montserrat `.ttf` files as assets and switch to
`GoogleFonts.config.allowRuntimeFetching = false`.

## Plugging in ElevenLabs (bonus)

`lib/data/services/elevenlabs_tts_service.dart` defines
`ElevenLabsTtsService` with the same `onStart / onComplete / onError`
contract as `TtsService`. To use it:

1. Add `http` and `audioplayers` to `pubspec.yaml`.
2. Fill in `_apiKey` / `_voiceId` (use `--dart-define` in real builds).
3. In `StoryViewModel`, construct `ElevenLabsTtsService()` and call
   `synthesizeAndPlay(storyText, ...)` from `readStory()` instead of
   `TtsService.speak`.

No other file needs to change - `StoryViewModel` already exposes
`AudioPlaybackState.loading/playing/error` for whichever engine is
behind it.

## Data-driven quiz

`QuizRepository.fetchQuiz()` returns a `QuizQuestionModel` parsed from
the same JSON shape given in the brief. `QuizCard` iterates
`question.options` to build `QuizOptionTile`s, so 3, 4, or 5 options
(or different wording entirely) render correctly with no code changes.
