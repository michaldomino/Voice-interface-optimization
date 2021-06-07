import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voice_interface_optimization/data/entities/tts_test.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/logic/speaker.dart';
import 'package:volume_control/volume_control.dart';

class TtsTestSpeaker extends StatefulWidget {
  final TtsTest ttsTest;

  const TtsTestSpeaker({Key? key, required this.ttsTest}) : super(key: key);

  @override
  _TtsTestSpeakerState createState() => _TtsTestSpeakerState();
}

class _TtsTestSpeakerState extends State<TtsTestSpeaker> {
  static const double MAXIMUM_VOLUME = 1.0;

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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: Icon(
              Icons.play_arrow,
              color: Colors.green,
              size: 70,
            ),
            onTap: _playSound,
          ),
        ),
      ],
    );
  }

  _playSound() async {
    var volume = await VolumeControl.volume;
    if (volume < MAXIMUM_VOLUME) {
      _showVolumeSnackBar();
    } else {
      _speaker.speak(widget.ttsTest.text);
    }
  }

  void _showVolumeSnackBar() {
    SnackBar snackBar = SnackBar(
      content: Text(S.of(context).pleaseSetTheVolumeToMaximum,
          style: TextStyle(color: Colors.black)),
      backgroundColor: Colors.yellow,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
