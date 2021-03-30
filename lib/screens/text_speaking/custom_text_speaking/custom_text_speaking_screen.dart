import 'package:flutter/material.dart';
import 'package:voice_interface_optimization/screens/text_speaking/text_speaking.dart';

class CustomTextSpeakingScreen extends StatefulWidget {
  CustomTextSpeakingScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _CustomTextSpeakingScreenState createState() =>
      _CustomTextSpeakingScreenState();
}

class _CustomTextSpeakingScreenState extends State<CustomTextSpeakingScreen> {
  String _currentText = '';

  @override
  Widget build(BuildContext context) {
    return TextSpeaking(
      currentText: _currentText,
      textToSpeakAccessor: () => _currentText,
      textInput: TextField(
        onChanged: (String value) {
          setState(() {
            _currentText = value;
          });
        },
      ),
    );
  }
}
