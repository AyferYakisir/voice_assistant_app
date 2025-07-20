import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  final FlutterTts _flutterTts = FlutterTts();

  TTSService() {
    _flutterTts.setLanguage("tr-TR");
    _flutterTts.setPitch(1.0);
  }

  Future speak(String text) async {
    await _flutterTts.speak(text);
  }

  Future stop() async {
    await _flutterTts.stop();
  }
}
