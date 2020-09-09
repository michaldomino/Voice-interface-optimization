import 'package:voice_interface_optimization/persistence/shared_preferences_wrapper.dart';

class TextLanguage {
  static String _textLanguage;

  static get textLanguage async {
    if (_textLanguage == null) {
      _textLanguage = await getTextLanguage();
    }
    return _textLanguage;
  }

  static set textLanguage(String value) {
    if (_textLanguage != value) {
      _textLanguage = value;
      setTextLanguage(_textLanguage);
    }
  }

  static Future<String> getTextLanguage() async {
    SharedPreferencesWrapper sharedPreferencesWrapper =
        await SharedPreferencesWrapper.getInstance();
    return sharedPreferencesWrapper.getTextsLanguage();
  }

  static Future setTextLanguage(String value) async {
    SharedPreferencesWrapper sharedPreferencesWrapper =
        await SharedPreferencesWrapper.getInstance();
    return sharedPreferencesWrapper.setTextsLanguageCode(value);
  }
}
