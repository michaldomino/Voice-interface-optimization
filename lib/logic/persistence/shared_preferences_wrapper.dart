import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_interface_optimization/logic/value_models/languages_codes_model.dart';

class SharedPreferencesWrapper {
  static const String _APP_LANGUAGE_CODE_KEY = 'appLanguageCode';
  static const String _TEXTS_LANGUAGE_CODE_KEY = 'textsLanguageCode';

  SharedPreferences _sharedPreferencesInstance;

  SharedPreferencesWrapper._(this._sharedPreferencesInstance);

  static Future<SharedPreferencesWrapper> getInstance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    SharedPreferencesWrapper instance =
        SharedPreferencesWrapper._(sharedPreferences);
    return instance;
  }

  String _getString(String key, String defaultValue) {
    String defaultTextsLanguageCode = defaultValue;
    String? value = _sharedPreferencesInstance.getString(key);
    if (value == null) {
      value = defaultTextsLanguageCode;
    }
    return value;
  }

  Future _setString(String key, String value) async {
    await _sharedPreferencesInstance.setString(key, value);
  }

  String getAppLanguageCode() {
    return _getString(_APP_LANGUAGE_CODE_KEY, LanguagesCodesModel.POLISH);
  }

  Future setAppLanguageCode(String value) async {
    await _setString(_APP_LANGUAGE_CODE_KEY, value);
  }

  String getTextsLanguage() {
    return _getString(_TEXTS_LANGUAGE_CODE_KEY, LanguagesCodesModel.POLISH);
  }

  Future setTextsLanguageCode(String value) async {
    await _setString(_TEXTS_LANGUAGE_CODE_KEY, value);
  }
}
