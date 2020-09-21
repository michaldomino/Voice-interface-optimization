import 'dart:convert';

import 'package:http/http.dart' as http;

class TextsRepository {
  static const String API_URL = 'https://aqueous-shelf-69777.herokuapp.com/api';
  static const String LANGUAGES_LIST_URL = '$API_URL/lang-list';
  static const String TEXTS_LIST_URL = '$API_URL/texts-list';

  Future<List<String>> fetchLanguages() async {
    http.Response response = await http.get(LANGUAGES_LIST_URL);
    if (response.statusCode == 200) {
      var languagesMaps = json.decode(response.body);
      List<String> languages = [];
      for (var languageMap in languagesMaps) {
        languages.add(languageMap['id']);
      }
      return languages;
    } else
      throw Exception('Failed to load languages.');
  }
}
