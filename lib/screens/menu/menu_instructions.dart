import 'package:flutter/material.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';

class MenuInstructions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).instruction)),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Text(S.of(context).instructionContent,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              )),
        ),
      ),
      backgroundColor: Colors.blue,
    );
  }
}
