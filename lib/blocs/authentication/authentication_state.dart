part of 'authentication_cubit.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoggingIn extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final Token token;

  AuthenticationAuthenticated(this.token);
}

class AuthenticationBadRequest extends AuthenticationState {
  final LoginBadRequestResponse loginBadRequestResponse;

  AuthenticationBadRequest(this.loginBadRequestResponse);
}

class AuthenticationUnauthorized extends AuthenticationState {
  final LoginUnauthorizedResponse loginUnauthenticatedResponse;

  AuthenticationUnauthorized(this.loginUnauthenticatedResponse);
}

class AuthenticationServiceUnavailable extends AuthenticationState {}

class AuthenticationUnknownError extends AuthenticationState {}

class RefreshTokenUnsuccessful extends AuthenticationState {}
