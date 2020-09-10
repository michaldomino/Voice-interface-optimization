import 'package:voice_interface_optimization/persistence/shared_preferences_wrapper.dart';

class TextsLanguage {
  static final TextsLanguage _instance = TextsLanguage._();

  factory TextsLanguage.getInstance() {
    return _instance;
  }

  TextsLanguage._();

  String _textLanguage;

  get textLanguage {
    return _textLanguage;
  }

  set textLanguage(String value) {
    if (_textLanguage != value) {
      _textLanguage = value;
      _setTextLanguage(_textLanguage);
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
