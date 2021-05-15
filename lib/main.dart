import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:voice_interface_optimization/blocs/authentication/authentication_cubit.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/blocs/texts_language/texts_language_cubit.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/screens/initial/initial_screen.dart';
import 'package:voice_interface_optimization/screens/login/login_screen.dart';
import 'package:voice_interface_optimization/screens/menu/menu_screen.dart';
import 'package:voice_interface_optimization/screens/register/register_screen.dart';
import 'package:voice_interface_optimization/screens/settings/settings.dart';
import 'package:voice_interface_optimization/screens/text_speaking/custom_text_speaking/custom_text_speaking_screen.dart';
import 'package:voice_interface_optimization/screens/voice_recognition/voice_recogniton_screen.dart';
import 'package:voice_interface_optimization/value_models/routes_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthenticationCubit()),
          BlocProvider(create: (context) => LocalizationCubit()),
          BlocProvider(create: (context) => TextsLanguageCubit()),
        ],
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
            RoutesModel.INITIAL: (context) => InitialScreen(),
            RoutesModel.MENU: (context) => MenuScreen(),
            RoutesModel.SETTINGS: (context) => Settings(),
            RoutesModel.CUSTOM_TEXT_SPEAKING: (context) =>
                CustomTextSpeakingScreen(),
            RoutesModel.VOICE_RECOGNITION: (context) =>
                VoiceRecognitionScreen(),
            RoutesModel.LOGIN: (context) => LoginScreen(),
            RoutesModel.REGISTER: (context) => RegisterScreen(),
          },
          initialRoute: RoutesModel.INITIAL,
        ));
  }
}
