import 'package:flutter/material.dart';
import '../services/asr_service.dart';
import '../services/tts_service.dart';

class VoiceButton extends StatefulWidget {
  final Function(String) onResult;
  const VoiceButton({super.key, required this.onResult});

  @override
  State<VoiceButton> createState() => _VoiceButtonState();
}

class _VoiceButtonState extends State<VoiceButton> {
  final ASRService _asrService = ASRService();
  final TTSService _ttsService = TTSService();

  bool _isListening = false;

  void _onPressed() async {
    if (!_isListening) {
      bool available = await _asrService.initialize();
      if (available) {
        setState(() => _isListening = true);
        _asrService.listen(onResult: (text) {
          widget.onResult(text);
        }, onDone: () async {
          setState(() => _isListening = false);
          String text = _asrService.lastRecognizedWords;
          if (text.isNotEmpty) {
            await _ttsService.speak(text);
          }
        });
      }
    } else {
      _asrService.stop();
      setState(() => _isListening = false);
    }
  }

  @override
  void dispose() {
    _asrService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _onPressed,
      child: Icon(_isListening ? Icons.mic : Icons.mic_none),
    );
  }
}
