import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voice_interface_optimization/data/DTOs/requests/login_request.dart';
import 'package:voice_interface_optimization/data/DTOs/requests/register_request.dart';

class AuthenticationService {
  static const String _API_URL = 'aqueous-shelf-69777.herokuapp.com';
  static final Uri _LOGIN_URI =
      Uri.https(_API_URL, '/authentication/api/login');
  static final Uri _REGISTER_URI =
      Uri.https(_API_URL, '/authentication/api/register');

  Future<http.Response> login(String userName, String password) {
    LoginRequest loginRequest = LoginRequest(userName, password);
    String jsonString = json.encode(loginRequest.toJson());
    return http.post(_LOGIN_URI,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonString);
  }

  Future<http.Response> register(String userName, String password) {
    RegisterRequest registerRequest = RegisterRequest(userName, password);
    String jsonString = json.encode(registerRequest.toJson());
    return http.post(_REGISTER_URI,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonString);
  }
}
