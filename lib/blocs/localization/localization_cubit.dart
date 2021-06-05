import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/logic/language.dart';
import 'package:voice_interface_optimization/logic/persistence/shared_preferences_wrapper.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial());

  Future changeAppLanguage(BuildContext context, Language language) async {
    var appLanguageState = state;
    if (appLanguageState is LocalizationChanged &&
        appLanguageState.language == language) {
      return;
    }
    await S.load(Locale.fromSubtags(languageCode: language.code));
    SharedPreferencesWrapper sharedPreferencesWrapper =
        await SharedPreferencesWrapper.getInstance();
    await sharedPreferencesWrapper.setAppLanguageCode(language.code);
    emit(LocalizationChanged(language));
  }
}
