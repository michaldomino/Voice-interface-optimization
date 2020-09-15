import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/logic/speaker.dart';
import 'package:voice_interface_optimization/screens/reusable/appbar.dart';
import 'package:voice_interface_optimization/screens/text_speaking/speaker_regulator.dart';
import 'package:yaml/yaml.dart';

class PredefinedTextSpeakingScreen extends StatefulWidget {
  PredefinedTextSpeakingScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PredefinedTextSpeakingScreenState createState() =>
      _PredefinedTextSpeakingScreenState();
}

class _PredefinedTextSpeakingScreenState
    extends State<PredefinedTextSpeakingScreen> {
  Speaker _speaker;
  String _textToSpeak;
  var _texts;

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
      return FutureBuilder<YamlMap>(
          future: _loadTextsList(),
          builder: (context, snapshot) {
            return Scaffold(
              appBar: CustomAppbar(context).get(),
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: DropdownButton(
                            isExpanded: true,
                            value: _textToSpeak,
                            items: snapshot.data.entries
                                .map((e) => DropdownMenuItem(
                                      value: e.value,
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
    });
  }

  Future<YamlMap> _loadTextsList() async {
    // File file = File('res/texts/pl.yaml');
    String yamlAsText = await rootBundle.loadString('res/texts/pl.yaml');
    _texts = loadYaml(yamlAsText);
    return _texts;
  }

  _playSound() async {
    _speaker.speak(_textToSpeak);
  }
}
