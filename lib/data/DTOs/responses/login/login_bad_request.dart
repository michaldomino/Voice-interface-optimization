class LoginBadRequestResponse {
  final String? username;
  final String? password;

  LoginBadRequestResponse({this.username, this.password});

  factory LoginBadRequestResponse.fromJsonMap(Map<String, dynamic> jsonMap) {
    return LoginBadRequestResponse(
      username: jsonMap['username'],
      password: jsonMap['password'],
    );
  }
}
