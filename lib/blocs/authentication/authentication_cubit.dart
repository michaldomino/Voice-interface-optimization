import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:voice_interface_optimization/data/DTOs/responses/login/login_bad_request.dart';
import 'package:voice_interface_optimization/data/DTOs/responses/login/login_unauthorized_response.dart';
import 'package:voice_interface_optimization/data/DTOs/responses/login/token.dart';
import 'package:voice_interface_optimization/data/repositories/authentication_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  Future login(String userName, String password) async {
    emit(AuthenticationLoggingIn());
    AuthenticationRepository authenticationRepository =
        AuthenticationRepository();
    var response = await authenticationRepository.login(userName, password);
    switch (response.statusCode) {
      case 200:
        {
          emit(AuthenticationAuthenticated(
              Token.fromJsonMap(json.decode(response.body))));
        }
        break;
      case 400:
        {
          emit(AuthenticationBadRequest(
              LoginBadRequestResponse.fromJsonMap(json.decode(response.body))));
        }
        break;
      case 401:
        {
          emit(AuthenticationUnauthorized(LoginUnauthorizedResponse.fromJsonMap(
              json.decode(response.body))));
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
