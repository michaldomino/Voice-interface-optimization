import 'package:voice_interface_optimization/logic/language.dart';
import 'package:voice_interface_optimization/logic/value_models/languages_codes_model.dart';

class LanguagesModel {
  static const ENGLISH = Language(LanguagesCodesModel.ENGLISH, 'English');
  static const POLISH = Language(LanguagesCodesModel.POLISH, 'Polski');

  static List<Language> get supportedLanguages => [ENGLISH, POLISH];
}