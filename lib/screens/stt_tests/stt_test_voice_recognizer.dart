import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SttTestVoiceRecognizer extends StatefulWidget {
  final void Function(String) onValueChangedCallback;

  const SttTestVoiceRecognizer({
    Key? key,
    required this.onValueChangedCallback,
  }) : super(key: key);

  @override
  _SttTestVoiceRecognizerState createState() => _SttTestVoiceRecognizerState();
}

class _SttTestVoiceRecognizerState extends State<SttTestVoiceRecognizer> {
  final stt.SpeechToText _recognizer = stt.SpeechToText();
  bool _isListening = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _onMicrophoneButtonPressed,
      child: _isListening
          ? Icon(Icons.mic_none_rounded)
          : Icon(Icons.mic_rounded),
      backgroundColor: _isListening ? Colors.red : Colors.blue,
    );
  }

  void _onMicrophoneButtonPressed() async {
    if (!_isListening) {
      bool available = await _recognizer.initialize(
        onStatus: (status) {
          setState(() {
            _isListening = status == _ListeningStates.LISTENING;
          });
          print('onStatus: $status');
        },
        onError: (val) {
          setState(() {
            _isListening = false;
          });
          print('onError: $val');
        },
      );
      if (available) {
        setState(() => _isListening = true);
        _recognizer.listen(onResult: (result) {
          widget.onValueChangedCallback(result.recognizedWords);
        });
      }
    } else {
      setState(() => _isListening = false);
      _recognizer.stop();
    }
  }
}

class _ListeningStates {
  static const String LISTENING = 'listening';
}
