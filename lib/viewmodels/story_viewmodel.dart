import 'package:flutter/foundation.dart';

import '../core/constants/app_strings.dart';
import '../core/utils/enums.dart';
import '../data/services/tts_service.dart';

/// Drives the "Read Me a Story" flow:
/// idle -> loading -> playing -> idle (success) or error (with retry).
///
/// Once narration completes for the first time, [hasFinishedOnce]
/// flips to true - this is what reveals the quiz in the View.
class StoryViewModel extends ChangeNotifier {
  StoryViewModel({TtsService? ttsService})
      : _ttsService = ttsService ?? TtsService() {
    _ttsService.setHandlers(
      onStart: _handleStart,
      onComplete: _handleComplete,
      onError: _handleError,
    );
  }

  final TtsService _ttsService;

  final String storyText = AppStrings.storyText;

  AudioPlaybackState _audioState = AudioPlaybackState.idle;
  AudioPlaybackState get audioState => _audioState;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _hasFinishedOnce = false;
  bool get hasFinishedOnce => _hasFinishedOnce;

  Future<void> readStory() async {
    if (_audioState == AudioPlaybackState.loading ||
        _audioState == AudioPlaybackState.playing) {
      return;
    }

    _errorMessage = null;
    _audioState = AudioPlaybackState.loading;
    notifyListeners();

    try {
      await _ttsService.speak(storyText);
    } catch (_) {
      _handleError('Speech engine unavailable. Please try again.');
    }
  }

  Future<void> stop() async {
    await _ttsService.stop();
    if (_audioState == AudioPlaybackState.playing ||
        _audioState == AudioPlaybackState.loading) {
      _audioState = AudioPlaybackState.idle;
      notifyListeners();
    }
  }

  void retry() {
    _errorMessage = null;
    _audioState = AudioPlaybackState.idle;
    notifyListeners();
    readStory();
  }

  void _handleStart() {
    _audioState = AudioPlaybackState.playing;
    notifyListeners();
  }

  void _handleComplete() {
    _audioState = AudioPlaybackState.idle;
    _hasFinishedOnce = true;
    notifyListeners();
  }

  void _handleError(String message) {
    _errorMessage = message;
    _audioState = AudioPlaybackState.error;
    notifyListeners();
  }

  @override
  void dispose() {
    _ttsService.stop();
    super.dispose();
  }
}
