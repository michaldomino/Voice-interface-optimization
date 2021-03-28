import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class PredefinedTexts {
  static PredefinedTexts _currentInstance = PredefinedTexts._();

  static final Map<String, PredefinedTexts> _cache =
      <String, PredefinedTexts>{};

  factory PredefinedTexts() {
    return _currentInstance;
  }

  PredefinedTexts._();

  YamlMap? _texts;

  YamlMap? get texts => _texts;

  static Future loadFromLanguageCode(String languageCode) async {
    if (_cache.containsKey(languageCode)) {
      _currentInstance = _cache[languageCode]!;
    }
    String textFilePath = 'res/texts/$languageCode.yaml';
    String yamlAsText = await rootBundle.loadString(textFilePath);
    YamlMap yamlMap = loadYaml(yamlAsText);
    PredefinedTexts instance = PredefinedTexts._();
    instance._texts = yamlMap;
    _currentInstance = instance;
    _cache[languageCode] = instance;
  }
}
