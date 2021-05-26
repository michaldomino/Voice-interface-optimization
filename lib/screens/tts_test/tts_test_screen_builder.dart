import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/tts_tests/tts_tests_cubit.dart';
import 'package:voice_interface_optimization/data/entities/tts_test.dart';
import 'package:voice_interface_optimization/screens/tts_test/tts_test_screen.dart';

class TtsTestScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TtsTest>?>(
      future: _load(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return TtsTestScreen(snapshot.data!);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<List<TtsTest>?> _load(BuildContext context) {
    return BlocProvider.of<TtsTestsCubit>(context).getTtsTests();
  }
}
