import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/blocs/texts_language/texts_language_cubit.dart';
import 'package:voice_interface_optimization/logic/persistence/shared_preferences_wrapper.dart';
import 'package:voice_interface_optimization/screens/login/login_screen.dart';

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
      return FutureBuilder(
          future: _loadLanguage(context),
          builder: (context, snapshot) {
            return LoginScreen();
          });
    });
  }

  Future _loadLanguage(BuildContext context) async {
    SharedPreferencesWrapper sharedPreferencesWrapper =
        await SharedPreferencesWrapper.getInstance();
    String appLanguage = sharedPreferencesWrapper.getAppLanguageCode();
    String textsLanguage = sharedPreferencesWrapper.getTextsLanguage();
    BlocProvider.of<LocalizationCubit>(context)
        .changeAppLanguage(context, appLanguage);
    BlocProvider.of<TextsLanguageCubit>(context)
        .changeTextsLanguage(context, textsLanguage);
  }
}
