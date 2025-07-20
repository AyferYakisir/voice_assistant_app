import 'package:flutter/material.dart';
import 'widgets/voice_button.dart';

void main() {
  runApp(const VoiceAssistantApp());
}

class VoiceAssistantApp extends StatelessWidget {
  const VoiceAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voice Assistant',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const VoiceAssistantHome(),
    );
  }
}

class VoiceAssistantHome extends StatefulWidget {
  const VoiceAssistantHome({super.key});

  @override
  State<VoiceAssistantHome> createState() => _VoiceAssistantHomeState();
}

class _VoiceAssistantHomeState extends State<VoiceAssistantHome> {
  String _transcribedText = "Konuşmak için mikrofon simgesine dokunun...";

  void onSpeechResult(String recognizedWords) {
    setState(() {
      _transcribedText = recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sesli Asistan")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            _transcribedText,
            style: const TextStyle(fontSize: 22.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      floatingActionButton: VoiceButton(
        onResult: onSpeechResult,
      ),
    );
  }
}
