import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:voice_interface_optimization/logic/persistence/shared_preferences_wrapper.dart';
import 'package:voice_interface_optimization/logic/speaker.dart';
import 'package:voice_interface_optimization/logic/text_language.dart';

part 'texts_language_state.dart';

class TextsLanguageCubit extends Cubit<TextsLanguageState> {
  TextsLanguageCubit() : super(TextsLanguageInitial());

  Future changeTextsLanguage(BuildContext context, String languageCode) async {
    TextsLanguage textsLanguage = TextsLanguage();
    if (textsLanguage.textLanguage != languageCode) {
      textsLanguage.textLanguage = languageCode;
      SharedPreferencesWrapper sharedPreferencesWrapper =
          await SharedPreferencesWrapper.getInstance();
      await sharedPreferencesWrapper.setTextsLanguageCode(languageCode);
      Speaker().setLanguage(languageCode);
      emit(TextsLanguageChanged());
    }
  }
}
