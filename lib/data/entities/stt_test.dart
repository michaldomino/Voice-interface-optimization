class SttTest {
  final int id;
  final String text;
  final String language;

  SttTest(this.id, this.text, this.language);

  factory SttTest.fromJsonMap(Map<String, dynamic> jsonMap) {
    return SttTest(
      jsonMap['id'],
      jsonMap['text'],
      jsonMap['language'],
    );
  }
}
