import 'package:flutter/material.dart';

class TtsTestRadioElement extends StatelessWidget {
  static const double _BOX_HEIGHT = 50.0;
  static const double _BOX_WIDTH = 100.0;

  final Color boxColor;
  final String text;
  final Color textColor;

  const TtsTestRadioElement(
      {Key? key,
      required this.boxColor,
      required this.text,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _BOX_HEIGHT,
      width: _BOX_WIDTH,
      decoration: BoxDecoration(
        color: boxColor,
        border: Border.all(width: 1),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Center(child: Text(text, style: TextStyle(fontSize: 30, color: textColor))),
    );
  }
}
