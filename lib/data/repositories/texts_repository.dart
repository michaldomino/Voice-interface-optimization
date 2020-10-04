import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voice_interface_optimization/data/models/predefined_text.dart';
import 'package:voice_interface_optimization/data/models/text_result.dart';

class TextsRepository {
  static const String API_URL = 'https://aqueous-shelf-69777.herokuapp.com/api';
  static const String LANGUAGES_LIST_URL = '$API_URL/lang-list';
  static const String TEXTS_LIST_URL = '$API_URL/text-list';
  static const String TEXT_RESULTS_CREATE_URL = '$API_URL/tr-create';

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

  Future<List<PredefinedText>> fetchTexts() async {
    var response = await http.get(TEXTS_LIST_URL);
    if (response.statusCode == 200) {
      var textsMaps = json.decode(utf8.decode(response.bodyBytes));
      List<PredefinedText> texts = [];
      for (var textMap in textsMaps) {
        texts.add(PredefinedText.fromJsonMap(textMap));
      }
      return texts;
    } else
      throw Exception('Failed to load texts.');
  }

  Future<http.Response> sendTextResults(List<TextResult> textResults) async {
    List<Map<String, dynamic>> jsonMapList = [];
    for (var textResult in textResults) {
      jsonMapList.add(textResult.toJson());
    }
    String jsonString = json.encode(jsonMapList);
    return http.post(TEXT_RESULTS_CREATE_URL,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonString);
  }
}
