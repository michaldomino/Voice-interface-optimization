import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/logic/speaker.dart';
import 'package:voice_interface_optimization/screens/reusable/custom_app_bar.dart';
import 'package:voice_interface_optimization/screens/text_speaking/speaker_regulator.dart';

class TextSpeaking extends StatefulWidget {
  final StatefulWidget textInput;
  final String currentText;
  final String Function() textToSpeakAccessor;

  const TextSpeaking(
      {Key? key,
      required this.textInput,
      required this.currentText,
      required this.textToSpeakAccessor})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextSpeakingState();
}

class _TextSpeakingState extends State<TextSpeaking> {
  late Speaker _speaker;

  @override
  void initState() {
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
        appBar: CustomAppBar(context).get(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0),
                    child: widget.textInput),
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

  _playSound() async {
    _speaker.speak(widget.textToSpeakAccessor());
  }
}
