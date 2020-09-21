class Text {
  final int id;
  final String key;
  final String language;
  final String text;

  Text(this.id, this.key, this.language, this.text);

  factory Text.fromJson(Map<String, dynamic> jsonMap) {
    return Text(
      jsonMap['id'],
      jsonMap['key'],
      jsonMap['language'],
      jsonMap['text'],
    );
  }
}
