import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/blocs/texts_language/texts_language_cubit.dart';
import 'package:voice_interface_optimization/logic/predefined_texts.dart';
import 'package:voice_interface_optimization/logic/speaker.dart';
import 'package:voice_interface_optimization/screens/reusable/appbar.dart';
import 'package:voice_interface_optimization/screens/text_speaking/speaker_regulator.dart';

class PredefinedTextSpeakingScreen extends StatefulWidget {
  @override
  _PredefinedTextSpeakingScreenState createState() =>
      _PredefinedTextSpeakingScreenState();
}

class _PredefinedTextSpeakingScreenState
    extends State<PredefinedTextSpeakingScreen> {
  Speaker _speaker;
  String _textToSpeak;

  @override
  initState() {
    super.initState();
    _speaker = Speaker();
  }

  @override
  void dispose() {
    super.dispose();
    _speaker.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
      return Scaffold(
        appBar: CustomAppbar(context).get(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0),
                    child: BlocBuilder<TextsLanguageCubit, TextsLanguageState>(
                        builder: (context, state) {
                      return DropdownButton(
                        isExpanded: true,
                        value: _textToSpeak,
                        items: PredefinedTexts()
                            .texts
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
                            _textToSpeak = value;
                          });
                        },
                      );
                    })),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.green,
                        size: 50,
                      ),
                      onTap: _playSound,
                    ),
                  ],
                ),
                SpeakerRegulator(_speaker),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Future _loadTextsList() async {
  //   PredefinedTexts predefinedTexts =
  //       await PredefinedTexts.loadFromLanguageCode(
  //           TextsLanguage().textLanguage);
  //   _texts = predefinedTexts.texts;
  // }

  _playSound() async {
    _speaker.speak(_textToSpeak);
  }
}
