import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voice_interface_optimization/data/DTOs/requests/login_request.dart';
import 'package:voice_interface_optimization/data/DTOs/requests/refresh_token_request.dart';
import 'package:voice_interface_optimization/data/DTOs/requests/register_request.dart';
import 'package:voice_interface_optimization/data/services/base_api_service.dart';

class AuthenticationService extends BaseApiService {
  static const String _LOGIN_PATH = '/authentication/api/login';
  static const String _REGISTER_PATH = '/authentication/api/register';
  static const String _REFRESH_TOKEN_PATH = '/authentication/api/refresh_token';

  Future<http.Response> login(String userName, String password) {
    LoginRequest loginRequest = LoginRequest(userName, password);
    return postUnauthenticatedRequest(json.encode(loginRequest), _LOGIN_PATH);
  }

  Future<http.Response> register(String userName, String password) {
    RegisterRequest registerRequest = RegisterRequest(userName, password);
    return postUnauthenticatedRequest(
        json.encode(registerRequest), _REGISTER_PATH);
  }

  Future<http.Response> refreshToken(String refreshToken) {
    RefreshTokenRequest refreshTokenRequest = RefreshTokenRequest(refreshToken);
    return postUnauthenticatedRequest(
        json.encode(refreshTokenRequest), _REFRESH_TOKEN_PATH);
  }
}
