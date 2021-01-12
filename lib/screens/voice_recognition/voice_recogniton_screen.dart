import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';

class VoiceRecognitionScreen extends StatefulWidget {
  @override
  _VoiceRecognitionScreenState createState() => _VoiceRecognitionScreenState();
}

class _VoiceRecognitionScreenState extends State<VoiceRecognitionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(title: Text('Voice recognition')),
            body: Text('Hello'));
      },
    );
  }
}
