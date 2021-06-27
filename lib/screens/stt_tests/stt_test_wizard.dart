import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/blocs/stt_tests/stt_tests_cubit.dart';
import 'package:voice_interface_optimization/data/DTOs/requests/stt_test_result.dart';
import 'package:voice_interface_optimization/data/entities/stt_test.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/screens/reusable/yes_no_alert_dialog.dart';
import 'package:voice_interface_optimization/screens/stt_tests/stt_test_wizard_stepper.dart';

class SttTestWizard extends StatefulWidget {
  final List<SttTest> sttTests;

  const SttTestWizard(this.sttTests, {Key? key}) : super(key: key);

  @override
  _SttTestWizardState createState() => _SttTestWizardState();
}

class _SttTestWizardState extends State<SttTestWizard> {
  bool _complete = false;
  late List<String> _results;

  late final void Function(int, String) _setResultsCallback;
  late final void Function(bool) _setCompleteCallback;

  @override
  void initState() {
    _results = List.filled(widget.sttTests.length, '');
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
    return Scaffold(
      appBar: AppBar(title: Text('Test')),
      floatingActionButton: _buildOnCompleteButton(),
      body: SttTestWizardStepper(
        sttTests: widget.sttTests,
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
        List<SttTestResult> sttTestResults = _results
            .asMap()
            .entries
            .map((e) => SttTestResult(widget.sttTests[e.key], e.value))
            .toList();
        await BlocProvider.of<SttTestsCubit>(context)
            .sendResults(sttTestResults);
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
