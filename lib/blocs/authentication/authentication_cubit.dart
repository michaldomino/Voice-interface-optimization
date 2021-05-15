import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:voice_interface_optimization/data/DTOs/responses/login/login_bad_request_response.dart';
import 'package:voice_interface_optimization/data/DTOs/responses/login/login_unauthorized_response.dart';
import 'package:voice_interface_optimization/data/DTOs/responses/login/token.dart';
import 'package:voice_interface_optimization/data/services/authentication_service.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  Future login(String userName, String password) async {
    emit(AuthenticationLoggingIn());
    AuthenticationService authenticationRepository =
        AuthenticationService();
    var response = await authenticationRepository.login(userName, password);
    switch (response.statusCode) {
      case HttpStatus.ok:
        {
          Token token = Token.fromJsonMap(json.decode(response.body));

          emit(AuthenticationAuthenticated(token));
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
}
