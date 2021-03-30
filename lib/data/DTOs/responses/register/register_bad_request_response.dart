class RegisterBadRequestResponse {
  final List<String>? username;
  final List<String>? password;

  RegisterBadRequestResponse({this.username, this.password});

  factory RegisterBadRequestResponse.fromJsonMap(Map<String, dynamic> jsonMap) {
    return RegisterBadRequestResponse(
      username: jsonMap['username']?.cast<String>(),
      password: jsonMap['password']?.cast<String>(),
    );
  }
}
