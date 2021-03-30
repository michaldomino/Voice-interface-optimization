class LoginBadRequestResponse {
  final List<String>? username;
  final List<String>? password;

  LoginBadRequestResponse({this.username, this.password});

  factory LoginBadRequestResponse.fromJsonMap(Map<String, dynamic> jsonMap) {
    return LoginBadRequestResponse(
      username: jsonMap['username']?.cast<String>(),
      password: jsonMap['password']?.cast<String>(),
    );
  }
}
