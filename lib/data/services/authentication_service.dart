import 'package:http/http.dart' as http;
import 'package:voice_interface_optimization/data/DTOs/requests/login_request.dart';
import 'package:voice_interface_optimization/data/DTOs/requests/refresh_token_request.dart';
import 'package:voice_interface_optimization/data/DTOs/requests/register_request.dart';
import 'package:voice_interface_optimization/data/services/base_api_service.dart';

class AuthenticationService extends BaseApiService {
  static const String _LOGIN_PATH = '/authentication/api/login';
  static const String _REGISTER_PATH = '/authentication/api/register';
  static const String _REFRESH_TOKEN_PATH = '/authentication/api/refresh_token';

  // static final Uri _LOGIN_URI =
  //     Uri.https(_API_URL, '/authentication/api/login');
  // static final Uri _REGISTER_URI =
  //     Uri.https(_API_URL, '/authentication/api/register');
  // static final Uri _REFRESH_TOKEN_URI =
  //     Uri.https(_API_URL, '/authentication/api/refresh_token');

  Future<http.Response> login(String userName, String password) {
    LoginRequest loginRequest = LoginRequest(userName, password);
    return postPublicRequest(loginRequest.toJson(), _LOGIN_PATH);
  }

  Future<http.Response> register(String userName, String password) {
    RegisterRequest registerRequest = RegisterRequest(userName, password);
    return postPublicRequest(registerRequest.toJson(), _REGISTER_PATH);
  }

  Future<http.Response> refreshToken(String refreshToken) {
    RefreshTokenRequest refreshTokenRequest = RefreshTokenRequest(refreshToken);
    return postPublicRequest(refreshTokenRequest.toJson(), _REFRESH_TOKEN_PATH);
  }
}
