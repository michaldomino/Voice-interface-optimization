import 'dart:convert';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:voice_interface_optimization/data/DTOs/responses/login/login_bad_request.dart';
import 'package:voice_interface_optimization/data/DTOs/responses/login/login_unauthorized_response.dart';
import 'package:voice_interface_optimization/data/DTOs/responses/login/token.dart';
import 'package:voice_interface_optimization/data/repositories/authentication_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  Future login(String login, String password) async {
    emit(AuthenticationLoggingIn());
    AuthenticationRepository authenticationRepository =
        AuthenticationRepository();
    var response = await authenticationRepository.login(login, password);
    var jsonMap = json.decode(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        {
          emit(AuthenticationAuthenticated(Token.fromJsonMap(jsonMap)));
        }
        break;
      case HttpStatus.badRequest:
        {
          emit(AuthenticationBadRequest(
              LoginBadRequestResponse.fromJsonMap(jsonMap)));
        }
        break;
      case HttpStatus.unauthorized:
        {
          emit(AuthenticationUnauthorized(
              LoginUnauthorizedResponse.fromJsonMap(jsonMap)));
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
