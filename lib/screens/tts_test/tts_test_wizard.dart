import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/data/entities/tts_test.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/screens/reusable/custom_radio.dart';
import 'package:voice_interface_optimization/screens/tts_test/custom_radio_element.dart';

class TtsTestWizard extends StatefulWidget {
  final List<TtsTest> ttsTests;

  const TtsTestWizard(this.ttsTests, {Key? key}) : super(key: key);

  @override
  _TtsTestWizardState createState() => _TtsTestWizardState();
}

class _TtsTestWizardState extends State<TtsTestWizard> {
  int _currentStep = 0;
  bool _complete = false;
  late List<bool?> _results;
  StepperType stepperType = StepperType.horizontal;

  @override
  void initState() {
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
    return Scaffold(
      appBar: AppBar(title: Text('Test')),
      floatingActionButton: _buildOnCompleteButton(),
      body: Stepper(
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
                  onPressed: _currentStep < ttsTests.length - 1
                      ? onStepContinue
                      : null,
                  child: Text(S.of(context).next),
                ),
              ),
            ],
          );
        },
        steps: ttsTests.asMap().entries.map((e) {
          // var radioModels = ;
          return Step(
              title: Text('Test ${e.key + 1}'),
              isActive: _currentStep >= 0,
              content: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(e.value.text),
                    CustomRadio<bool?>(_buildRadioModels(), _results[e.key],
                        (value) {
                      setState(() => _results[e.key] = value);
                      if (_results.every((element) => element != null)) {
                        setState(() {
                          _complete = true;
                        });
                      }
                    }),
                  ],
                ),
              ));
        }).toList(),
      ),
    );
  }

  List<RadioModel<bool?>> _buildRadioModels() {
    return [
      RadioModel(
        true,
        CustomRadioElement(
            boxColor: Colors.green,
            // text: S.of(context).yes,
            text: S.of(context).yes,
            textColor: Colors.black),
        CustomRadioElement(
            boxColor: Colors.transparent,
            text: S.of(context).yes,
            textColor: Colors.green),
      ),
      RadioModel(
        false,
        CustomRadioElement(
            boxColor: Colors.red,
            text: S.of(context).no,
            textColor: Colors.black),
        CustomRadioElement(
            boxColor: Colors.transparent,
            text: S.of(context).no,
            textColor: Colors.red),
      ),
    ];
  }

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

  Widget? _buildOnCompleteButton() {
    if (_complete)
      return FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {},
      );
  }
}
