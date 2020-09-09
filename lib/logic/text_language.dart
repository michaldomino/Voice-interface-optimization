import 'package:voice_interface_optimization/persistence/shared_preferences_wrapper.dart';

class TextLanguage {
  static final TextLanguage _instance = TextLanguage._();

  factory TextLanguage.getInstance() {
    return _instance;
  }

  TextLanguage._();

  String _textLanguage;

  get textLanguage async {
    if (_textLanguage == null) {
      _textLanguage = await _getTextLanguage();
    }
    return _textLanguage;
  }

  set textLanguage(String value) {
    if (_textLanguage != value) {
      _textLanguage = value;
      _setTextLanguage(_textLanguage);
    }
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
