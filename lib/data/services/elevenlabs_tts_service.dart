import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';

class ElevenLabsTtsService {
  // Read keys safely from the loaded environment variables
  static String get _apiKey => dotenv.env['ELEVENLABS_API_KEY'] ?? '';
  static String get _voiceId => dotenv.env['ELEVENLABS_VOICE_ID'] ?? '21m00Tcm4TlvDq8ikWAM';
  static const String _baseUrl = 'https://api.elevenlabs.io/v1/text-to-speech';

  // Instantiate the player once to manage memory and playback states
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> synthesizeAndPlay(
    String text, {
    required void Function() onStart,
    required void Function() onComplete,
    required void Function(String message) onError,
  }) async {
    // 1. Guard check for API key
    if (_apiKey.isEmpty) {
      onError('ElevenLabs configuration error: API Key is missing in .env file.');
      return;
    }

    try {
      // 2. Generate an MD5 hash of the text to use as the filename
      final String textHash = md5.convert(utf8.encode(text)).toString();
      
      // 3. Get the device's temporary directory
      final Directory tempDir = await getTemporaryDirectory();
      final File cachedAudioFile = File('${tempDir.path}/$textHash.mp3');

      // 4. Check if we already have this audio cached locally
      if (!await cachedAudioFile.exists()) {
        // --- NETWORK FETCH (Cache Miss) ---
        
        final response = await http.post(
          Uri.parse('$_baseUrl/$_voiceId'),
          headers: {
            'xi-api-key': _apiKey,
            'Content-Type': 'application/json',
            'accept': 'audio/mpeg',
          },
          body: jsonEncode({
            'text': text,
            'model_id': 'eleven_multilingual_v2',
            'voice_settings': {
              'stability': 0.4, 
              'similarity_boost': 0.8
            },
          }),
        );

        if (response.statusCode != 200) {
          onError('ElevenLabs request failed (Status: ${response.statusCode})');
          return;
        }

        // Write the downloaded audio bytes to the temp file
        await cachedAudioFile.writeAsBytes(response.bodyBytes);
      }

      // --- PLAYBACK ---
      
      // Listen for when the audio finishes playing
      _audioPlayer.onPlayerComplete.listen((event) {
        onComplete();
      });

      // Trigger the start callback right before we begin playback
      onStart();

      // Play the cached local file using DeviceFileSource
      await _audioPlayer.play(DeviceFileSource(cachedAudioFile.path));

    } catch (e) {
      onError('A network, file, or playback error occurred: ${e.toString()}');
    }
  }

  // Optional but recommended: Add a method to stop playback and dispose
  // if the user navigates away from the story screen early.
  void dispose() {
    _audioPlayer.dispose();
  }
}