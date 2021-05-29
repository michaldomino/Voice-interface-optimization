import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/data/entities/tts_test.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/screens/reusable/custom_radio.dart';

class TtsTestWizard extends StatefulWidget {
  final List<TtsTest> ttsTests;

  const TtsTestWizard(this.ttsTests, {Key? key}) : super(key: key);

  @override
  _TtsTestWizardState createState() => _TtsTestWizardState();
}

class _TtsTestWizardState extends State<TtsTestWizard> {
  int _currentStep = 0;
  bool? _complete = false;
  late List<bool?> _results;
  StepperType stepperType = StepperType.horizontal;

  @override
  void initState() {
    // _results = widget.ttsTests.map((e) => TtsTestResult(e, false)).toList();
    _results = List.filled(widget.ttsTests.length, null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
      return _buildWizard();
    });
  }

  _buildWizard() {
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
            content: Column(
              children: [
                Text(e.value.text),
                // Checkbox(
                //     value: _results[e.key],
                //     onChanged: (value) {
                //       setState(() {
                //         _results[e.key] = value;
                //       });
                //       if (_results.every((element) => element != null)) {
                //         setState(() {
                //           _complete = true;
                //         });
                //       }
                //     }),
                CustomRadio<bool?>(_radioModels,
                //     [RadioModel(
                //     true,
                //     Text('tak', style: TextStyle(color: Colors.green)),
                //     Text('tak', style: TextStyle(color: Colors.red)),
                //   ),
                //   RadioModel(
                //     false,
                //     Text('nie', style: TextStyle(color: Colors.green)),
                //     Text('nie', style: TextStyle(color: Colors.red)),
                //   ),
                // ],
                    _results[e.key],
                    (value) {
                  setState(() => _results[e.key] = value);
                  if (_results.every((element) => element != null)) {
                    setState(() {
                      _complete = true;
                    });
                  }
                }),
              ],
            ));
      }).toList(),
    );
  }

  List<RadioModel<bool?>> _radioModels = [
    RadioModel(
      true,
      Text('tak', style: TextStyle(color: Colors.green)),
      Text('tak', style: TextStyle(color: Colors.red)),
    ),
    RadioModel(
      false,
      Text('nie', style: TextStyle(color: Colors.green)),
      Text('nie', style: TextStyle(color: Colors.red)),
    ),
  ];

  _continue(List<TtsTest> ttsTests) {
    _currentStep + 1 < ttsTests.length
        ? _goTo(_currentStep + 1)
        : setState(() => _complete = true);
  }

  _goTo(int step) {
    setState(() => _currentStep = step);
  }

  _cancel() {
    if (_currentStep > 0) {
      _goTo(_currentStep - 1);
    }
  }

  void _a(int index, bool? value) {
    setState(() => _results[index] = value);
    if (_results.every((element) => element != null)) {
      setState(() {
        _complete = true;
      });
    }
  }
}
