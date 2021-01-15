import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/screens/reusable/appbar.dart';

class VoiceRecognitionScreen extends StatefulWidget {
  @override
  _VoiceRecognitionScreenState createState() => _VoiceRecognitionScreenState();
}

class _VoiceRecognitionScreenState extends State<VoiceRecognitionScreen> {
  stt.SpeechToText _speaker;
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _speaker = stt.SpeechToText();
  }

  void _onMicrophoneButtonPressed() async {
    if (!_isListening) {
      bool available = await _speaker.initialize(
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
        _speaker.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speaker.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
      return Scaffold(
        appBar: CustomAppbar(context).get(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: _onMicrophoneButtonPressed,
          child: _isListening
              ? Icon(Icons.mic_none)
              : Icon(
                  Icons.mic,
                ),
          backgroundColor: _isListening ? Colors.red : Colors.blue,
        ),
        body: Center(
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
      );
    });
  }
}
