import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/blocs/tts_tests/tts_tests_cubit.dart';
import 'package:voice_interface_optimization/data/DTOs/requests/tts_test_result.dart';
import 'package:voice_interface_optimization/data/entities/tts_test.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/screens/reusable/yes_no_alert_dialog.dart';
import 'package:voice_interface_optimization/screens/tts_test/tts_test_wizard_stepper.dart';

class TtsTestWizard extends StatefulWidget {
  final List<TtsTest> ttsTests;

  const TtsTestWizard(this.ttsTests, {Key? key}) : super(key: key);

  @override
  _TtsTestWizardState createState() => _TtsTestWizardState();
}

class _TtsTestWizardState extends State<TtsTestWizard> {
  bool _complete = false;
  late List<bool?> _results;
  StepperType stepperType = StepperType.horizontal;

  late final void Function(int, bool?) _setResultsCallback;
  late final void Function(bool) _setCompleteCallback;

  @override
  void initState() {
    _results = List.filled(widget.ttsTests.length, null);
    _setResultsCallback =
        (index, value) => setState(() => _results[index] = value);
    _setCompleteCallback = (value) => setState(() => _complete = value);
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
    // var ttsTests = widget.ttsTests;
    return Scaffold(
      appBar: AppBar(title: Text('Test')),
      floatingActionButton: _buildOnCompleteButton(),
      body: TtsTestWizardStepper(
        ttsTests: widget.ttsTests,
        results: _results,
        setResultsCallback: _setResultsCallback,
        setCompleteCallback: _setCompleteCallback,
      ),
    );
  }

  Widget? _buildOnCompleteButton() {
    if (_complete)
      return FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => _buildYesNoAlertDialog().build(context));
        },
      );
  }

  AlertDialog _buildYesNoAlertDialog() {
    return YesNoAlertDialog(
      titleText: 'Alert',
      contentText: S.of(context).doYouWantToSendTheResults,
      onYesAction: () async {
        List<TtsTestResult> ttsTestResults = _results
            .asMap()
            .entries
            .map((e) => TtsTestResult(widget.ttsTests[e.key], e.value!))
            .toList();
        await BlocProvider.of<TtsTestsCubit>(context)
            .sendResults(ttsTestResults);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        _showResultsSnackBar();
      },
      onNoAction: () {
        Navigator.of(context).pop();
      },
    ).build(context);
  }

  void _showResultsSnackBar() {
    SnackBar snackBar = SnackBar(
      content: Text(S.of(context).thankYouForParticipatingInTheStudy),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
