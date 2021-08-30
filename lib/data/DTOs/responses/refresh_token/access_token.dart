class AccessToken {
  final String access;

  AccessToken(this.access);

  factory AccessToken.fromJsonMap(Map<String, dynamic> jsonMap) {
    return AccessToken(
      jsonMap['access'],
    );
  }
}
