class RegisterRequest {
  String userName;
  String password;

  RegisterRequest(this.userName, this.password);

  Map<String, dynamic> toJson() => {
    'username': userName,
    'password': password,
  };
}