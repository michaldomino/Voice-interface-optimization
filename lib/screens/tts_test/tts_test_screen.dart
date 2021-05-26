import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/blocs/tts_tests/tts_tests_cubit.dart';
import 'package:voice_interface_optimization/data/entities/tts_test.dart';
import 'package:voice_interface_optimization/screens/reusable/appbar.dart';

class TtsTestScreen extends StatefulWidget {
  final List<TtsTest> ttsTests;

  const TtsTestScreen(this.ttsTests, {Key? key}) : super(key: key);

  @override
  _TtsTestScreenState createState() => _TtsTestScreenState();
}

class _TtsTestScreenState extends State<TtsTestScreen> {
  int _currentStep = 0;
  bool? _complete = false;
  List<bool?> a = <bool?>[];
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

  _x(int index, bool? value) {
    setState(() {
      _complete = value;
    });
  }

  List<Step> steps2 = <Step>[];

  @override
  void initState() {
    a = List.filled(widget.ttsTests.length, false);
    // steps2 = widget.ttsTests.asMap().entries.map((e) {
    //   return Step(
    //       title: Text('Test ${e.key + 1}'),
    //       isActive: _currentStep >= 0,
    //       // state: _getStepState(e.key),
    //       content: Column(
    //         children: [
    //           Text(e.value.text),
    //           Checkbox(
    //               value: a[e.key],
    //               onChanged: (value) => setState(() {
    //                     a[e.key] = value;
    //                   })),
    //         ],
    //       ));
    // }).toList();
    // steps2 = [
    //   Step(
    //     title: const Text('New Account'),
    //     isActive: true,
    //     state: StepState.complete,
    //     content: Column(
    //       children: <Widget>[
    //         Text('A'),
    //         Checkbox(value: _complete, onChanged: (value) => _x(0, value)),
    //       ],
    //     ),
    //   ),
    //   Step(
    //     isActive: false,
    //     state: StepState.editing,
    //     title: const Text('Address'),
    //     content: Column(
    //       children: <Widget>[
    //         TextFormField(
    //           decoration: InputDecoration(labelText: 'Home Address'),
    //         ),
    //         TextFormField(
    //           decoration: InputDecoration(labelText: 'Postcode'),
    //         ),
    //       ],
    //     ),
    //   ),
    //   Step(
    //     state: StepState.error,
    //     title: const Text('Avatar'),
    //     subtitle: const Text("Error!"),
    //     content: Column(
    //       children: <Widget>[
    //         CircleAvatar(
    //           backgroundColor: Colors.red,
    //         )
    //       ],
    //     ),
    //   ),
    // ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
      return Scaffold(
          appBar: CustomAppbar(context).getTitled("Test"),
          body: _buildScreen());
    });
  }

  _buildScreen() {
    // List<bool?> answers = List.filled(state.ttsTests.length, false);
      var ttsTests = widget.ttsTests;
      // a = List.filled(ttsTests.length, false);
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
                  child: Text("Previous"),
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: _currentStep < ttsTests.length - 1
                      ? onStepContinue
                      : null,
                  child: Text("Next"),
                ),
              ),
            ],
          );
        },
        // steps: steps2,
        steps: ttsTests.asMap().entries.map((e) {
          return Step(
              title: Text('Test ${e.key + 1}'),
              isActive: _currentStep >= 0,
              // state: _getStepState(e.key),
              content: Column(
                children: [
                  Text(e.value.text),
                  Checkbox(
                      value: a[e.key],
                      onChanged: (value) => setState(() {
                            a[e.key] = value;
                          })),
                ],
              ));
        }).toList(),
      );
  }

  // else {
  // return CircularProgressIndicator();
  // }

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

  StepState _getStepState(int index) {
    if (index < _currentStep) return StepState.complete;
    if (index == _currentStep) return StepState.editing;
    return StepState.disabled;
  }

  Future<List<TtsTest>?> _loadTtsTests(BuildContext context) {
    return BlocProvider.of<TtsTestsCubit>(context).getTtsTests();
  }
//   @override
// // TODO: implement wantKeepAlive
//   bool get wantKeepAlive => true;
}

class _StepData {
  String text;
  int index;

  _StepData(this.text, this.index);
}
