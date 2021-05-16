import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/blocs/texts_language/texts_language_cubit.dart';
import 'package:voice_interface_optimization/logic/persistence/shared_preferences_wrapper.dart';
import 'package:voice_interface_optimization/screens/login/login_screen.dart';
import 'package:voice_interface_optimization/screens/splash/splash_screen.dart';

class InitialScreen extends StatelessWidget {
  static const int _SPLASH_SCREEN_DURATION_TIME_SEC = 3;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
      return FutureBuilder(
          future: _loadLanguage(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return LoginScreen();
            } else {
              return SplashScreen();
            }
          });
    });
  }

  Future _loadLanguage(BuildContext context) async {
    SharedPreferencesWrapper sharedPreferencesWrapper =
        await SharedPreferencesWrapper.getInstance();
    String appLanguage = sharedPreferencesWrapper.getAppLanguageCode();
    String textsLanguage = sharedPreferencesWrapper.getTextsLanguage();
    Future splashScreenDurationSeconds =
        Future.delayed(Duration(seconds: _SPLASH_SCREEN_DURATION_TIME_SEC));
    Future changeAppLanguageFuture = BlocProvider.of<LocalizationCubit>(context)
        .changeAppLanguage(context, appLanguage);
    Future changeTextsLanguageFuture =
        BlocProvider.of<TextsLanguageCubit>(context)
            .changeTextsLanguage(context, textsLanguage);
    await Future.wait([
      changeAppLanguageFuture,
      changeTextsLanguageFuture,
      splashScreenDurationSeconds
    ]);
  }
}
