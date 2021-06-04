import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:voice_interface_optimization/data/DTOs/responses/is_verified/is_verified_response.dart';
import 'package:voice_interface_optimization/data/DTOs/responses/login/login_bad_request_response.dart';
import 'package:voice_interface_optimization/data/DTOs/responses/login/login_unauthorized_response.dart';
import 'package:voice_interface_optimization/data/DTOs/responses/login/token.dart';
import 'package:voice_interface_optimization/data/DTOs/responses/refresh_token/access_token.dart';
import 'package:voice_interface_optimization/data/services/authentication_service.dart';
import 'package:voice_interface_optimization/logic/persistence/flutter_secure_storage_wrapper.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationService _authenticationService;

  AuthenticationCubit(this._authenticationService)
      : super(AuthenticationInitial());

  Future login(String userName, String password) async {
    emit(AuthenticationLoggingIn());
    var response = await _authenticationService.login(userName, password);
    switch (response.statusCode) {
      case HttpStatus.ok:
        {
          Token token = Token.fromJsonMap(json.decode(response.body));
          var isVerifiedResponse =
              await _authenticationService.isVerified(token.access);
          IsVerifiedResponse isVerified = IsVerifiedResponse.fromJsonMap(
              json.decode(isVerifiedResponse.body));
          if (isVerified.isVerified) {
            var flutterSecureStorage = FlutterSecureStorageWrapper();
            await flutterSecureStorage.setRefreshToken(token.refresh);
            emit(AuthenticationAuthenticated(token));
          } else {
            emit(AuthenticationNotVerified());
          }
        }
        break;
      case HttpStatus.badRequest:
        {
          emit(AuthenticationBadRequest(
              LoginBadRequestResponse.fromJsonMap(json.decode(response.body))));
        }
        break;
      case HttpStatus.unauthorized:
        {
          emit(AuthenticationUnauthorized(LoginUnauthorizedResponse.fromJsonMap(
              json.decode(response.body))));
        }
        break;
      case HttpStatus.serviceUnavailable:
        {
          emit(AuthenticationServiceUnavailable());
        }
        break;
      default:
        {
          emit(AuthenticationUnknownError());
        }
        break;
    }
  }

  Future refreshToken(String? refreshToken) async {
    if (refreshToken == null) {
      emit(RefreshTokenUnsuccessful());
      return;
    }
    var response = await _authenticationService.refreshToken(refreshToken);
    switch (response.statusCode) {
      case HttpStatus.ok:
        {
          AccessToken accessToken =
              AccessToken.fromJsonMap(json.decode(response.body));
          Token token = Token(accessToken.access, refreshToken);
          var isVerifiedResponse =
              await _authenticationService.isVerified(token.access);
          IsVerifiedResponse isVerified = IsVerifiedResponse.fromJsonMap(
              json.decode(isVerifiedResponse.body));
          if (isVerified.isVerified) {
            emit(AuthenticationAuthenticated(token));
          } else {
            emit(AuthenticationNotVerified());
          }
        }
        break;
      default:
        {
          emit(RefreshTokenUnsuccessful());
        }
        break;
    }
  }

  Future logout() async {
    emit(AuthenticationLoggingOut());
    FlutterSecureStorageWrapper flutterSecureStorageWrapper =
        FlutterSecureStorageWrapper();
    await flutterSecureStorageWrapper.deleteRefreshToken();
    emit(AuthenticationLoggedOut());
  }
}
