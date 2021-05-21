import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/authentication/authentication_cubit.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/blocs/texts_language/texts_language_cubit.dart';
import 'package:voice_interface_optimization/logic/language.dart';
import 'package:voice_interface_optimization/logic/persistence/flutter_secure_storage_wrapper.dart';
import 'package:voice_interface_optimization/logic/persistence/shared_preferences_wrapper.dart';
import 'package:voice_interface_optimization/screens/login/login_screen.dart';
import 'package:voice_interface_optimization/screens/menu/menu_screen.dart';
import 'package:voice_interface_optimization/screens/splash/splash_screen.dart';

class InitialScreen extends StatelessWidget {
  static const int _SPLASH_SCREEN_DURATION_TIME_SEC = 3;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
      return FutureBuilder(
          future: _loadConfiguration(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationAuthenticated) {
                    return MenuScreen();
                  } else {
                    return LoginScreen();
                  }
                },
              );
            } else {
              return SplashScreen();
            }
          });
    });
  }

  Future _loadConfiguration(BuildContext context) async {
    SharedPreferencesWrapper sharedPreferencesWrapper =
        await SharedPreferencesWrapper.getInstance();
    String appLanguage = sharedPreferencesWrapper.getAppLanguageCode();
    String textsLanguage = sharedPreferencesWrapper.getTextsLanguage();
    Future splashScreenDurationSeconds =
        Future.delayed(Duration(seconds: _SPLASH_SCREEN_DURATION_TIME_SEC));
    await Future.wait([
      _loadAppLanguage(context, appLanguage),
      _loadTextsLanguage(context, textsLanguage),
      _refreshToken(context),
      splashScreenDurationSeconds,
    ]);
  }

  Future _loadAppLanguage(BuildContext context, String appLanguageCode) {
    return BlocProvider.of<LocalizationCubit>(context)
        .changeAppLanguage(context, Language.fromLanguageCode(appLanguageCode));
  }

  Future _loadTextsLanguage(BuildContext context, String textsLanguageCode) {
    return BlocProvider.of<TextsLanguageCubit>(context).changeTextsLanguage(
        context, Language.fromLanguageCode(textsLanguageCode));
  }

  Future _refreshToken(BuildContext context) async {
    var flutterSecureStorageWrapper = FlutterSecureStorageWrapper();
    String? refreshToken = await flutterSecureStorageWrapper.getRefreshToken();
    BlocProvider.of<AuthenticationCubit>(context).refreshToken(refreshToken);
  }
}
