import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:voice_interface_optimization/logic/language.dart';
import 'package:voice_interface_optimization/logic/persistence/shared_preferences_wrapper.dart';
import 'package:voice_interface_optimization/logic/speaker.dart';

part 'texts_language_state.dart';

class TextsLanguageCubit extends Cubit<TextsLanguageState> {
  TextsLanguageCubit() : super(TextsLanguageInitial());

  Future changeTextsLanguage(BuildContext context, Language language) async {
    var textLanguageState = state;
    if (textLanguageState is TextsLanguageChanged &&
        textLanguageState.language == language) {
      return;
    }
    SharedPreferencesWrapper sharedPreferencesWrapper =
        await SharedPreferencesWrapper.getInstance();
    await sharedPreferencesWrapper.setTextsLanguageCode(language.code);
    Speaker().setLanguage(language.code);
    emit(TextsLanguageChanged(language));
  }
}
