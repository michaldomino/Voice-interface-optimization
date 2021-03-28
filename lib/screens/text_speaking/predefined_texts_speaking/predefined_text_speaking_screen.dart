import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/texts_language/texts_language_cubit.dart';
import 'package:voice_interface_optimization/logic/predefined_texts.dart';
import 'package:voice_interface_optimization/screens/text_speaking/text_speaking.dart';

class PredefinedTextSpeakingScreen extends StatefulWidget {
  @override
  _PredefinedTextSpeakingScreenState createState() =>
      _PredefinedTextSpeakingScreenState();
}

class _PredefinedTextSpeakingScreenState
    extends State<PredefinedTextSpeakingScreen> {
  late String _currentText;

  @override
  Widget build(BuildContext context) {
    return TextSpeaking(
      currentText: _currentText,
      textToSpeakAccessor: () => PredefinedTexts().texts?[_currentText],
      textInput: BlocBuilder<TextsLanguageCubit, TextsLanguageState>(
          builder: (context, state) {
        return DropdownButton(
          isExpanded: true,
          value: _currentText,
          items: PredefinedTexts()
              .texts!
              .entries
              .map((e) => DropdownMenuItem(
                    value: e.key,
                    child: FittedBox(
                      child: Text(e.value),
                      fit: BoxFit.contain,
                    ),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _currentText = value as String;
            });
          },
        );
      }),
    );
  }
}
