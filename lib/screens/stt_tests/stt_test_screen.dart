import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/stt_tests/stt_tests_cubit.dart';
import 'package:voice_interface_optimization/data/entities/stt_test.dart';
import 'package:voice_interface_optimization/screens/stt_tests/stt_test_wizard.dart';

class SttTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SttTest>?>(
      future: _loadSttTests(context),
      builder: (context, snapshot) {
        return _buildScreen(snapshot);
      },
    );
  }

  Future<List<SttTest>?> _loadSttTests(BuildContext context) {
    return BlocProvider.of<SttTestsCubit>(context).getSttTests();
  }

  Widget _buildScreen(AsyncSnapshot<List<SttTest>?> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      return SttTestWizard(snapshot.data!);
    } else {
      return Scaffold(
          appBar: AppBar(title: Text('Test')),
          body: Center(child: CircularProgressIndicator()));
    }
  }
}
