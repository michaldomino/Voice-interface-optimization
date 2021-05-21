import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/blocs/tts_tests/tts_tests_cubit.dart';
import 'package:voice_interface_optimization/screens/reusable/appbar.dart';

class TtsTestScreen extends StatefulWidget {
  @override
  _TtsTestScreenState createState() => _TtsTestScreenState();
}

class _TtsTestScreenState extends State<TtsTestScreen> {
  int _currentStep = 0;
  bool _complete = false;
  StepperType stepperType = StepperType.horizontal;

  List<_StepData> _stepsData = [
    _StepData("a", 0),
    _StepData("b", 1),
  ];
  List<Step> _steps = [
    Step(
      title: const Text('New Account'),
      isActive: true,
      state: StepState.complete,
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Email Address'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
          ),
        ],
      ),
    ),
    Step(
      isActive: false,
      state: StepState.editing,
      title: const Text('Address'),
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Home Address'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Postcode'),
          ),
        ],
      ),
    ),
    Step(
      state: StepState.error,
      title: const Text('Avatar'),
      subtitle: const Text("Error!"),
      content: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.red,
          )
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppbar(context).getTitled("Test"),
          body: BlocBuilder<TtsTestsCubit, TtsTestsState>(
            builder: (context, state) {
              if (state is TtsTestsLoaded) {
                return Stepper(
                  currentStep: _currentStep,
                  type: stepperType,
                  onStepContinue: _continue,
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
                            child: Text("Previous"),
                          ),
                        ),
                        Container(
                          child: ElevatedButton(
                            onPressed: _currentStep < _stepsData.length - 1
                                ? onStepContinue
                                : null,
                            child: Text("Next"),
                          ),
                        ),
                      ],
                    );
                  },
                  steps: state.ttsTests.asMap().entries.map((e) {
                    return Step(
                        title: Text('Test ${e.key + 1}'),
                        isActive: _currentStep >= 0,
                        state:
                          _currentStep < e.key
                            ? StepState.complete
                            : StepState.disabled,

                        content: Text(e.value.text));
                  }).toList(),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        );
      },
    );
  }

  _continue() {
    _currentStep + 1 < _stepsData.length
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
}

class _StepData {
  String text;
  int index;

  _StepData(this.text, this.index);
}
