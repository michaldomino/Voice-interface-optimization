import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/blocs/texts_language/texts_language_cubit.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/logic/routes_model.dart';
import 'package:voice_interface_optimization/screens/menu/menu_screen.dart';
import 'package:voice_interface_optimization/screens/settings/settings.dart';
import 'package:voice_interface_optimization/screens/text_speaking/custom_text_speaking/custom_text_speaking_screen.dart';
import 'package:voice_interface_optimization/screens/text_speaking/predefined_texts_speaking/predefined_text_speaking_screen.dart';
import 'package:voice_interface_optimization/screens/voice_recognition/voice_recogniton_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LocalizationCubit(),
        child: BlocProvider(
          create: (context) => TextsLanguageCubit(),
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
//        GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            routes: {
              RoutesModel.HOME_SCREEN: (context) => MenuScreen(),
              RoutesModel.SETTINGS: (context) => Settings(),
              RoutesModel.CUSTOM_TEXT_SPEAKING: (context) =>
                  CustomTextSpeakingScreen(),
              RoutesModel.PREDEFINED_TEXT_SPEAKING: (context) =>
                  PredefinedTextSpeakingScreen(),
              RoutesModel.VOICE_RECOGNITION: (context) =>
                  VoiceRecognitionScreen(),
            },
            initialRoute: RoutesModel.HOME_SCREEN,
          ),
        ));
  }
}
