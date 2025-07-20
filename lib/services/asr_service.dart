import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class ASRService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  String lastRecognizedWords = "";

  Future<bool> initialize() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
    }
    return await _speech.initialize();
  }

  void listen({required Function(String) onResult, Function()? onDone}) {
    _speech.listen(
      localeId: "tr_TR",
      onResult: (val) {
        lastRecognizedWords = val.recognizedWords;
        onResult(val.recognizedWords);
      },
      onSoundLevelChange: null,
      onDone: () {
        if (onDone != null) onDone();
      },
    );
  }

  void stop() {
    _speech.stop();
  }
}
