class TtsTest {
  final int id;
  final String text;
  final String language;
  final double volume;
  final double pitch;
  final double rate;

  TtsTest(
      this.id, this.text, this.language, this.volume, this.pitch, this.rate);

  factory TtsTest.fromJsonMap(Map<String, dynamic> jsonMap) {
    return TtsTest(
      jsonMap['id'],
      jsonMap['text'],
      jsonMap['language'],
      jsonMap['volume'],
      jsonMap['pitch'],
      jsonMap['rate'],
    );
  }
}
