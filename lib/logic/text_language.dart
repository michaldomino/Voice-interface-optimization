import 'package:voice_interface_optimization/persistence/shared_preferences_wrapper.dart';
import 'package:voice_interface_optimization/value_models/languages_codes_model.dart';

class TextsLanguage {
  static final TextsLanguage _instance = TextsLanguage._();

  factory TextsLanguage() {
    return _instance;
  }

  TextsLanguage._();

  String? _textLanguage;

  String? get textLanguage {
    return _textLanguage;
  }

  List<String> get supportedLanguages =>
      [LanguagesCodesModel.ENGLISH, LanguagesCodesModel.POLISH];

  set textLanguage(String? value) {
    if (value != null && _textLanguage != value) {
      _textLanguage = value;
      _setTextLanguage(value);
    }
  }

  Future loadLanguage() async {
    _textLanguage = await _getTextLanguage();
  }

  Future<String> _getTextLanguage() async {
    SharedPreferencesWrapper sharedPreferencesWrapper =
        await SharedPreferencesWrapper.getInstance();
    return sharedPreferencesWrapper.getTextsLanguage();
  }

  Future _setTextLanguage(String value) async {
    SharedPreferencesWrapper sharedPreferencesWrapper =
        await SharedPreferencesWrapper.getInstance();
    return sharedPreferencesWrapper.setTextsLanguageCode(value);
  }
}
