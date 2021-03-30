class PredefinedText {
  final int id;
  final String key;
  final String language;
  final String text;

  PredefinedText(this.id, this.key, this.language, this.text);

  factory PredefinedText.fromJsonMap(Map<String, dynamic> jsonMap) {
    return PredefinedText(
      jsonMap['id'],
      jsonMap['key'],
      jsonMap['language'],
      jsonMap['text'],
    );
  }
}
