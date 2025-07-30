import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  static final TTSService _instance = TTSService._internal();
  factory TTSService() => _instance;
  TTSService._internal();

  final FlutterTts _flutterTts = FlutterTts();
  bool _isCatalanAvailable = false;

  Future<List<dynamic>> _loadVoicesWithRetry() async {
    List<dynamic> voices = [];
    int tries = 0;

    while (voices.isEmpty && tries < 3) {
      if (tries > 0) {
        await Future.delayed(Duration(milliseconds: 500 * tries));
      }
      voices = await _flutterTts.getVoices;
      tries++;
    }
    return voices;
  }

  Future<void> initTTS() async {
    List<dynamic> voices = [];
    if (kIsWeb) {
      voices = await _loadVoicesWithRetry();
    } else {
      voices = await _flutterTts.getVoices;
    }

    print("Veus disponibles:");
    voices.forEach((v) => print(v));

    final herenaVoice = voices.firstWhere(
      (voice) {
        final name = (voice['name'] ?? '').toString().toLowerCase();
        final locale = (voice['locale'] ?? voice['lang'] ?? '').toString().toLowerCase();
        return locale == 'ca-es' && name.contains('herena');
      },
      orElse: () => null,
    );

    if (herenaVoice != null) {
      _isCatalanAvailable = true;
      print("Veu catalana trobada: ${herenaVoice['name']}");
      await _flutterTts.setVoice({
        'name': herenaVoice['name'],
        'locale': herenaVoice['locale'] ?? herenaVoice['lang'],
      });
      await _flutterTts.setLanguage("ca-ES");
    } else {
      _isCatalanAvailable = await _flutterTts.isLanguageAvailable("ca-ES");
      if (_isCatalanAvailable) {
        print("Idioma català disponible però veu específica no trobada. S'utilitza idioma ca-ES.");
        await _flutterTts.setLanguage("ca-ES");
      } else {
        print("La veu catalana no està disponible. Utilitzant l'idioma per defecte.");
      }
    }

    await _flutterTts.setSpeechRate(0.6);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }

  bool get isCatalanAvailable => _isCatalanAvailable;
}