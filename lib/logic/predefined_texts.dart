import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class PredefinedTexts {
  static final Map<String, PredefinedTexts> _cache =
      <String, PredefinedTexts>{};

  PredefinedTexts._(this._texts);

  YamlMap _texts;

  YamlMap get texts => _texts;

  static Future<PredefinedTexts> fromLanguageCode(String languageCode) async {
    if (_cache.containsKey(languageCode)) return _cache[languageCode];
    String textFilePath = 'res/texts/$languageCode.yaml';
    String yamlAsText = await rootBundle.loadString(textFilePath);
    YamlMap yamlMap = loadYaml(yamlAsText);
    PredefinedTexts instance = PredefinedTexts._(yamlMap);
    _cache[languageCode] = instance;
    return instance;
  }
}
