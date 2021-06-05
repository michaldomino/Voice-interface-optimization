import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:voice_interface_optimization/generated/l10n.dart';

class SttTestVoiceRecognizer extends StatefulWidget {
  @override
  _SttTestVoiceRecognizerState createState() => _SttTestVoiceRecognizerState();
}

class _SttTestVoiceRecognizerState extends State<SttTestVoiceRecognizer> {
  stt.SpeechToText _recognizer = stt.SpeechToText();
  bool _isListening = false;
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Column(
            children: <Widget>[
              Text(
                S.of(context).recognizedText,
                style: TextStyle(fontSize: 30.0),
              ),
              Text(
                _text,
                style: TextStyle(fontSize: 20.0),
              )
            ],
          ),
        ),
        FloatingActionButton(
          onPressed: _onMicrophoneButtonPressed,
          child: _isListening
              ? Icon(Icons.mic_none_rounded)
              : Icon(Icons.mic_rounded),
          backgroundColor: _isListening ? Colors.red : Colors.blue,
        ),
      ],
    );
  }

  void _onMicrophoneButtonPressed() async {
    if (!_isListening) {
      bool available = await _recognizer.initialize(
        onStatus: (val) {
          setState(() {
            _isListening = val == 'listening';
          });
          print('onStatus: $val');
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
        _recognizer.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _recognizer.stop();
    }
  }
}
