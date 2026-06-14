import 'package:flutter_tts/flutter_tts.dart';

/// Thin wrapper around [FlutterTts] so [StoryViewModel] never talks to
/// the plugin directly.
///
/// This keeps the on-device engine and the optional
/// [ElevenLabsTtsService] (see elevenlabs_tts_service.dart)
/// interchangeable - both expose start / complete / error callbacks
/// with the same shape.
class TtsService {
  TtsService() {
    _configure();
  }

  final FlutterTts _flutterTts = FlutterTts();

  void _configure() {
    _flutterTts.setLanguage('en-US');
    _flutterTts.setSpeechRate(0.45);
    _flutterTts.setPitch(1.05);
  }

  void setHandlers({
    required void Function() onStart,
    required void Function() onComplete,
    required void Function(String message) onError,
  }) {
    _flutterTts.setStartHandler(onStart);
    _flutterTts.setCompletionHandler(onComplete);
    _flutterTts.setErrorHandler((message) => onError(message.toString()));
  }

  Future<void> speak(String text) async {
    await _flutterTts.stop();
    await _flutterTts.speak(text);
  }

  Future<void> stop() => _flutterTts.stop();
}
