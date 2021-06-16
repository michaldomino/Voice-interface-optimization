import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/authentication/authentication_cubit.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/data/DTOs/responses/login/login_bad_request_response.dart';
import 'package:voice_interface_optimization/data/DTOs/responses/login/login_unauthorized_response.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/logic/value_models/routes_model.dart';
import 'package:voice_interface_optimization/screens/login/login_screen_appbar.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const double _TOP_FORM_MARGIN = 30.0;
  static const double _HORIZONTAL_FORM_MARGIN = 30.0;
  static const double _TOP_FORM_FIELD_MARGIN = 15.0;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _userNameEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  String? _userNameErrors;
  String? _passwordErrors;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) => {
        if (state is AuthenticationAuthenticated)
          {Navigator.pushReplacementNamed(context, RoutesModel.MENU)}
        else if (state is AuthenticationBadRequest)
          {_onBadRequest(state.loginBadRequestResponse)}
        else if (state is AuthenticationUnauthorized)
          {_onUnauthorized(state.loginUnauthenticatedResponse)}
        else if (state is AuthenticationServiceUnavailable)
          {_onServiceUnavailable()}
        else if (state is AuthenticationNotVerified)
            {_onNotVerified()}
        else if (state is AuthenticationUnknownError)
          {_onUnknownError()}
      },
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
          builder: (context, state) {
        return Scaffold(
          appBar: LoginScreenAppbar(context).get(),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(
                  top: _TOP_FORM_MARGIN,
                  left: _HORIZONTAL_FORM_MARGIN,
                  right: _HORIZONTAL_FORM_MARGIN),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _userNameEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: S.of(context).login,
                      ),
                      validator: (String? value) {
                        return _userNameErrors;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: _TOP_FORM_FIELD_MARGIN),
                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordEditingController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: S.of(context).password,
                        ),
                        validator: (String? value) {
                          return _passwordErrors;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: _TOP_FORM_FIELD_MARGIN),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _userNameErrors = null;
                            _passwordErrors = null;
                            _formKey.currentState!.validate();
                          });
                          BlocProvider.of<AuthenticationCubit>(context).login(
                              _userNameEditingController.text,
                              _passwordEditingController.text);
                        },
                        child: Text(S.of(context).submit),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  _onBadRequest(LoginBadRequestResponse loginBadRequestResponse) {
    setState(() {
      _userNameErrors = loginBadRequestResponse.username?.join(' ');
      _passwordErrors = loginBadRequestResponse.password?.join(' ');
      _formKey.currentState!.validate();
    });
  }

  _onUnauthorized(LoginUnauthorizedResponse loginUnauthenticatedResponse) {
    _showSnackBar(
        text: loginUnauthenticatedResponse.detail, backgroundColor: Colors.red);
    // SnackBar snackBar = SnackBar(
    //   content: Text(loginUnauthenticatedResponse.detail),
    //   backgroundColor: Colors.red,
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _onServiceUnavailable() {
    _showSnackBar(
        text: S.of(context).serverIsDown, backgroundColor: Colors.orange);
    // SnackBar snackBar = SnackBar(
    //   content: Text(S.of(context).serverIsDown),
    //   backgroundColor: Colors.orange,
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _onUnknownError() {
    _showSnackBar(
        text: S.of(context).somethingWentWrong, backgroundColor: Colors.red);
    // SnackBar snackBar = SnackBar(
    //   content: Text(S.of(context).somethingWentWrong),
    //   backgroundColor: Colors.red,
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _onNotVerified() {
    _showSnackBar(
        text: S.of(context).youAreNotVerifiedYet,
        backgroundColor: Colors.yellow);
    // SnackBar snackBar = SnackBar(
    //   content: Text(
    //     S.of(context).youAreNotVerifiedYet,
    //     style: TextStyle(color: Colors.black),
    //   ),
    //   backgroundColor: Colors.yellow,
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _showSnackBar(
      {required String text,
      Color textColor = Colors.black,
      required Color backgroundColor}) {
    SnackBar snackBar = SnackBar(
        content: Text(text, style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
