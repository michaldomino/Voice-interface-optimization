import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/tts_tests/tts_tests_cubit.dart';
import 'package:voice_interface_optimization/data/entities/tts_test.dart';
import 'package:voice_interface_optimization/screens/reusable/appbar.dart';
import 'package:voice_interface_optimization/screens/tts_test/tts_test_wizard.dart';

class TtsTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TtsTest>?>(
      future: _load(context),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: CustomAppbar(context).getTitled("Test"),
          body: _buildBody(snapshot),
        );
      },
    );
  }

  Future<List<TtsTest>?> _load(BuildContext context) {
    return BlocProvider.of<TtsTestsCubit>(context).getTtsTests();
  }

  Widget _buildBody(AsyncSnapshot<List<TtsTest>?> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      return TtsTestWizard(snapshot.data!);
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
