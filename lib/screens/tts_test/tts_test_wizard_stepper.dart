import 'package:flutter/material.dart';
import 'package:voice_interface_optimization/data/entities/tts_test.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/screens/reusable/custom_radio.dart';
import 'package:voice_interface_optimization/screens/tts_test/tts_test_radio_element.dart';
import 'package:voice_interface_optimization/screens/tts_test/tts_test_speaker.dart';

class TtsTestWizardStepper extends StatefulWidget {
  final List<TtsTest> ttsTests;
  final List<bool?> results;
  final void Function(int, bool?) setResultsCallback;
  final void Function(bool) setCompleteCallback;

  const TtsTestWizardStepper({
    Key? key,
    required this.ttsTests,
    required this.results,
    required this.setResultsCallback,
    required this.setCompleteCallback,
  }) : super(key: key);

  @override
  _TtsTestWizardStepperState createState() => _TtsTestWizardStepperState();
}

class _TtsTestWizardStepperState extends State<TtsTestWizardStepper> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;

  @override
  Widget build(BuildContext context) {
    var ttsTests = widget.ttsTests;
    return Stepper(
      currentStep: _currentStep,
      type: stepperType,
      onStepContinue: () => _continue(ttsTests),
      onStepTapped: (step) => _goTo(step),
      onStepCancel: _cancel,
      controlsBuilder: (context, {onStepContinue, onStepCancel}) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: ElevatedButton(
                onPressed: _currentStep > 0 ? onStepCancel : null,
                child: Text(S.of(context).previous),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed:
                    _currentStep < ttsTests.length - 1 ? onStepContinue : null,
                child: Text(S.of(context).next),
              ),
            ),
          ],
        );
      },
      steps: ttsTests.asMap().entries.map((e) {
        return Step(
            title: Text('Test ${e.key + 1}'),
            isActive: _currentStep >= 0,
            state: widget.results[e.key] != null
                ? StepState.complete
                : StepState.indexed,
            content: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(S.of(context).isTextClearlyAudible),
                  TtsTestSpeaker(ttsTest: e.value),
                  CustomRadio<bool?>(_buildRadioModels(), widget.results[e.key],
                      (value) {
                    widget.setResultsCallback(e.key, value);
                    if (widget.results.every((element) => element != null)) {
                      widget.setCompleteCallback(true);
                    }
                  }),
                ],
              ),
            ));
      }).toList(),
    );
  }

  List<RadioModel<bool?>> _buildRadioModels() {
    return [
      RadioModel(
        true,
        TtsTestRadioElement(
            boxColor: Colors.green,
            text: S.of(context).yes,
            textColor: Colors.black),
        TtsTestRadioElement(
            boxColor: Colors.transparent,
            text: S.of(context).yes,
            textColor: Colors.green),
      ),
      RadioModel(
        false,
        TtsTestRadioElement(
            boxColor: Colors.red,
            text: S.of(context).no,
            textColor: Colors.black),
        TtsTestRadioElement(
            boxColor: Colors.transparent,
            text: S.of(context).no,
            textColor: Colors.red),
      ),
    ];
  }

  _continue(List<TtsTest> ttsTests) {
    if (_currentStep + 1 < ttsTests.length) {
      _goTo(_currentStep + 1);
    }
  }

  _goTo(int step) {
    setState(() => _currentStep = step);
  }

  _cancel() {
    if (_currentStep > 0) {
      _goTo(_currentStep - 1);
    }
  }
}
