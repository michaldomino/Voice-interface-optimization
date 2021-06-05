import 'package:flutter/material.dart';
import 'package:voice_interface_optimization/data/entities/stt_test.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/screens/stt_tests/stt_test_voice_recognizer.dart';

class SttTestWizardStepper extends StatefulWidget {
  final List<SttTest> sttTests;
  final List<String> results;
  final void Function(int, String) setResultsCallback;
  final void Function(bool) setCompleteCallback;

  const SttTestWizardStepper({
    Key? key,
    required this.sttTests,
    required this.results,
    required this.setResultsCallback,
    required this.setCompleteCallback,
  }) : super(key: key);

  @override
  _SttTestWizardStepperState createState() => _SttTestWizardStepperState();
}

class _SttTestWizardStepperState extends State<SttTestWizardStepper> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;

  @override
  Widget build(BuildContext context) {
    var sttTests = widget.sttTests;
    return Stepper(
      currentStep: _currentStep,
      type: stepperType,
      onStepContinue: () => _continue(sttTests),
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
                    _currentStep < sttTests.length - 1 ? onStepContinue : null,
                child: Text(S.of(context).next),
              ),
            ),
          ],
        );
      },
      steps: sttTests.asMap().entries.map((e) {
        return Step(
            title: Text('Test ${e.key + 1}'),
            isActive: _currentStep >= 0,
            state: widget.results[e.key] != ''
                ? StepState.complete
                : StepState.indexed,
            content: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      S.of(context).clickTheButtonToRecordTheVoice,
                      style: TextStyle(fontSize: 30.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SttTestVoiceRecognizer(
                    onValueChangedCallback: (value) {
                      setState(() {
                        widget.setResultsCallback(e.key, value);
                        widget.setCompleteCallback(widget.results
                            .every((element) => element.isNotEmpty));
                      });
                    },
                  ),
                ],
              ),
            ));
      }).toList(),
    );
  }

  _continue(List<SttTest> sttTests) {
    if (_currentStep + 1 < sttTests.length) {
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
