import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/logic/speaker.dart';
import 'package:voice_interface_optimization/screens/reusable/appbar.dart';
import 'package:voice_interface_optimization/screens/text_speaking/speaker_regulator.dart';

class CustomTextSpeakingScreen extends StatefulWidget {
  CustomTextSpeakingScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CustomTextSpeakingScreenState createState() =>
      _CustomTextSpeakingScreenState();
}

class _CustomTextSpeakingScreenState extends State<CustomTextSpeakingScreen> {
  Speaker _speaker;
  String _textToSpeak;

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
        appBar: CustomAppbar(context).get(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0),
                    child: TextField(
                      onChanged: (String value) {
                        setState(() {
                          _textToSpeak = value;
                        });
                      },
                    )),
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
    _speaker.speak(_textToSpeak);
  }
}
