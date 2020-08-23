import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_interface_optimization/models/languages_codes_model.dart';

class SharedPreferencesWrapper {
  static const String _LANGUAGE_CODE_KEY = 'languageCode';

  SharedPreferences _sharedPreferencesInstance;

  SharedPreferencesWrapper._(this._sharedPreferencesInstance);

  static getInstance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    SharedPreferencesWrapper instance =
        SharedPreferencesWrapper._(sharedPreferences);
    return instance;
  }

  String getLanguageCode() {
    String defaultLanguageCode = LanguagesCodesModel.ENGLISH;
    String languageCode =
        _sharedPreferencesInstance.getString(_LANGUAGE_CODE_KEY);
    if (languageCode == null) {
      languageCode = defaultLanguageCode;
//      setLanguageCode(languageCode);
    }
    return languageCode;
  }

  Future setLanguageCode(String value) async {
    await _sharedPreferencesInstance.setString(_LANGUAGE_CODE_KEY, value);
  }
}
