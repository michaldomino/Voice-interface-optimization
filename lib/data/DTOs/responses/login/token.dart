class Token {
  final String access;
  final String refresh;

  Token(this.access, this.refresh);

  factory Token.fromJsonMap(Map<String, dynamic> jsonMap) {
    return Token(
      jsonMap['access'],
      jsonMap['refresh'],
    );
  }
}
