import 'package:flutter/material.dart';
import 'package:voice_interface_optimization/logic/speaker.dart';

class SpeakerRegulator extends StatefulWidget {
  final Speaker speaker;

  const SpeakerRegulator(this.speaker, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SpeakerRegulatorState();
}

class _SpeakerRegulatorState extends State<SpeakerRegulator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Slider(
            value: widget.speaker.volume,
            onChanged: (newVolume) {
              setState(() => widget.speaker.volume = newVolume);
            },
            min: 0.0,
            max: 1.0,
            divisions: 10,
            label: "Volume: ${widget.speaker.volume}"),
        Slider(
          value: widget.speaker.pitch,
          onChanged: (newPitch) {
            setState(() => widget.speaker.pitch = newPitch);
          },
          min: 0.5,
          max: 2.0,
          divisions: 15,
          label: "Pitch: ${widget.speaker.pitch}",
          activeColor: Colors.red,
        ),
        Slider(
          value: widget.speaker.rate,
          onChanged: (newRate) {
            setState(() => widget.speaker.rate = newRate);
          },
          min: 0.0,
          max: 1.0,
          divisions: 10,
          label: "Rate: ${widget.speaker.rate}",
          activeColor: Colors.green,
        )
      ],
    );
  }
}
