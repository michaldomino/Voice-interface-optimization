import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voice_interface_optimization/data/models/text.dart';

class TextsRepository {
  static const String API_URL = 'https://aqueous-shelf-69777.herokuapp.com/api';
  static const String LANGUAGES_LIST_URL = '$API_URL/lang-list';
  static const String TEXTS_LIST_URL = '$API_URL/text-list';

  Future<List<String>> fetchLanguages() async {
    var response = await http.get(LANGUAGES_LIST_URL);
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

  Future<List<Text>> fetchTexts() async {
    var response = await http.get(TEXTS_LIST_URL);
    if (response.statusCode == 200) {
      var textsMaps = json.decode(utf8.decode(response.bodyBytes));
      List<Text> texts = [];
      // var a = textsMaps.map((e) => Text.fromJsonMap(e));
      for (var textMap in textsMaps) {
        texts.add(Text.fromJsonMap(textMap));
      }
      return texts;
    } else
      throw Exception('Failed to load texts.');
  }
}
