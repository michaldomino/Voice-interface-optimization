class UserCreatedResponse {
  final int id;
  final String userName;

  UserCreatedResponse(this.id, this.userName);

  factory UserCreatedResponse.fromJsonMap(Map<String, dynamic> jsonMap) {
    return UserCreatedResponse(
      jsonMap['id'],
      jsonMap['userName'],
    );
  }
}
