import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:voice_interface_optimization/blocs/authentication/authentication_cubit.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/blocs/stt_tests/stt_tests_cubit.dart';
import 'package:voice_interface_optimization/blocs/texts_language/texts_language_cubit.dart';
import 'package:voice_interface_optimization/blocs/tts_tests/tts_tests_cubit.dart';
import 'package:voice_interface_optimization/data/services/authentication_service.dart';
import 'package:voice_interface_optimization/data/services/stt_tests_service.dart';
import 'package:voice_interface_optimization/data/services/tts_tests_service.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/logic/value_models/routes_model.dart';
import 'package:voice_interface_optimization/screens/initial/initial_screen.dart';
import 'package:voice_interface_optimization/screens/login/login_screen.dart';
import 'package:voice_interface_optimization/screens/menu/menu_instructions.dart';
import 'package:voice_interface_optimization/screens/menu/menu_screen.dart';
import 'package:voice_interface_optimization/screens/register/register_screen.dart';
import 'package:voice_interface_optimization/screens/settings/settings.dart';
import 'package:voice_interface_optimization/screens/splash/splash_screen.dart';
import 'package:voice_interface_optimization/screens/stt_tests/stt_test_screen.dart';
import 'package:voice_interface_optimization/screens/tts_test/tts_test_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  AuthenticationCubit(AuthenticationService())),
          BlocProvider(create: (context) => LocalizationCubit()),
          BlocProvider(create: (context) => TextsLanguageCubit()),
          BlocProvider(
              create: (context) => TtsTestsCubit(
                    BlocProvider.of<TextsLanguageCubit>(context),
                    BlocProvider.of<AuthenticationCubit>(context),
                    TtsTestsService(),
                  )),
          BlocProvider(
              create: (context) => SttTestsCubit(
                    BlocProvider.of<TextsLanguageCubit>(context),
                    BlocProvider.of<AuthenticationCubit>(context),
                    SttTestsService(),
                  )),
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
            RoutesModel.SPLASH: (context) => SplashScreen(),
            RoutesModel.MENU: (context) => MenuScreen(),
            RoutesModel.SETTINGS: (context) => Settings(),
            RoutesModel.LOGIN: (context) => LoginScreen(),
            RoutesModel.REGISTER: (context) => RegisterScreen(),
            RoutesModel.TTS_TEST: (context) => TtsTestScreen(),
            RoutesModel.STT_TEST: (context) => SttTestScreen(),
            RoutesModel.MENU_INSTRUCTIONS: (context) => MenuInstructions(),
          },
          initialRoute: RoutesModel.INITIAL,
        ));
  }
}
