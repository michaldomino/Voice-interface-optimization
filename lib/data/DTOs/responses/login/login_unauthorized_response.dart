class LoginUnauthorizedResponse {
  final String detail;

  LoginUnauthorizedResponse(this.detail);

  factory LoginUnauthorizedResponse.fromJsonMap(Map<String, dynamic> jsonMap) {
    return LoginUnauthorizedResponse(
      jsonMap['detail'],
    );
  }
}
