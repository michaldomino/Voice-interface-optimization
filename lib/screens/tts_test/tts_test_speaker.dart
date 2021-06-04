import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voice_interface_optimization/data/entities/tts_test.dart';
import 'package:voice_interface_optimization/logic/speaker.dart';

class TtsTestSpeaker extends StatefulWidget {
  final TtsTest ttsTest;

  const TtsTestSpeaker({Key? key, required this.ttsTest}) : super(key: key);

  @override
  _TtsTestSpeakerState createState() => _TtsTestSpeakerState();
}

class _TtsTestSpeakerState extends State<TtsTestSpeaker> {
  late Speaker _speaker;

  @override
  void initState() {
    super.initState();
    _speaker = Speaker();
    _speaker.volume = widget.ttsTest.volume;
    _speaker.pitch = widget.ttsTest.pitch;
    _speaker.rate = widget.ttsTest.rate;
  }

  @override
  void dispose() {
    super.dispose();
    _speaker.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }

  _playSound() async {
    _speaker.speak(widget.ttsTest.text);
  }
}
