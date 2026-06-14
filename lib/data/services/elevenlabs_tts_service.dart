// Placeholder for the optional ElevenLabs integration mentioned in the
// brief ("Bonus: integrate a real free-tier API such as ElevenLabs").
//
// This mirrors TtsService's contract (onStart / onComplete / onError)
// so StoryViewModel can swap implementations with a single constructor
// change - nothing else in the app needs to know which engine is used.
//
// --- How to wire it up ---
// 1. Add `http` (or `dio`) and `audioplayers` to pubspec.yaml.
// 2. Fill in your API key + voice ID below. In production, pass these
//    in via --dart-define or a secure config - never hardcode them.
// 3. In StoryViewModel, construct ElevenLabsTtsService() instead of
//    TtsService() and call synthesizeAndPlay(storyText, ...) from
//    readStory().
//
// Caching note: cache the resulting audio bytes against a hash of the
// story text (e.g. in a temp file named after md5(text)) so repeat
// narrations of the same story don't re-hit the network - see README
// "Caching approach".

class ElevenLabsTtsService {
  // TODO: move to a secure config / --dart-define before shipping.
  static const String _apiKey = 'YOUR_ELEVENLABS_API_KEY';
  static const String _voiceId = 'YOUR_VOICE_ID';
  static const String _baseUrl = 'https://api.elevenlabs.io/v1/text-to-speech';

  Future<void> synthesizeAndPlay(
    String text, {
    required void Function() onStart,
    required void Function() onComplete,
    required void Function(String message) onError,
  }) async {
    // Example sketch (left unimplemented so the sample keeps working
    // offline with the on-device TtsService by default):
    //
    // final response = await http.post(
    //   Uri.parse('$_baseUrl/$_voiceId'),
    //   headers: {
    //     'xi-api-key': _apiKey,
    //     'Content-Type': 'application/json',
    //   },
    //   body: jsonEncode({
    //     'text': text,
    //     'model_id': 'eleven_multilingual_v2',
    //     'voice_settings': {'stability': 0.4, 'similarity_boost': 0.8},
    //   }),
    // );
    //
    // if (response.statusCode != 200) {
    //   onError('ElevenLabs request failed (${response.statusCode})');
    //   return;
    // }
    //
    // 1. Write response.bodyBytes to a cached temp .mp3 file
    //    (keyed by a hash of `text`).
    // 2. Play it with `audioplayers`, calling onStart() on playback
    //    start and onComplete() on playback completion.
    // 3. Catch network/timeout errors and call onError(...) so the
    //    existing AudioPlaybackState.error UI handles it.

    onError('ElevenLabs integration not configured. Add your API key.');
  }
}
