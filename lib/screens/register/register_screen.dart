import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/data/DTOs/responses/register/register_bad_request_response.dart';
import 'package:voice_interface_optimization/data/services/authentication_service.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/screens/register/register_screen_appbar.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const double _TOP_FORM_MARGIN = 30.0;
  static const double _HORIZONTAL_FORM_MARGIN = 30.0;
  static const double _TOP_FORM_FIELD_MARGIN = 15.0;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _userNameEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  TextEditingController _confirmPasswordEditingController =
      TextEditingController();

  String? _userNameErrors;
  String? _passwordErrors;

  final AuthenticationService _authenticationRepository =
      AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
      return Scaffold(
        appBar: RegisterScreenAppbar(context).get(),
        body: Container(
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
                  child: TextFormField(
                    obscureText: true,
                    controller: _confirmPasswordEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: S.of(context).confirmPassword,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty)
                        return S.of(context).pleaseEnterSomeText;
                      if (value != _passwordEditingController.text)
                        return 'Passwords do not match';
                      return null;
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
                      });
                      if (_formKey.currentState!.validate()) {
                        _register(_userNameEditingController.text,
                            _passwordEditingController.text);
                      }
                    },
                    child: Text(S.of(context).submit),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> _register(String userName, String password) async {
    var response = await _authenticationRepository.register(userName, password);
    switch (response.statusCode) {
      case HttpStatus.created:
        {
          _onUserCreated();
        }
        break;
      case HttpStatus.badRequest:
        {
          RegisterBadRequestResponse registerBadRequestResponse =
              RegisterBadRequestResponse.fromJsonMap(
                  json.decode(response.body));
          _onBadRequest(registerBadRequestResponse);
        }
        break;
      default:
        {
          _onUnknownError();
        }
        break;
    }
  }

  void _onUserCreated() {
    SnackBar snackBar = SnackBar(
      content: Text(S.of(context).accountCreatedSuccessfully),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _onUnknownError() {
    SnackBar snackBar = SnackBar(
      content: Text(S.of(context).somethingWentWrong),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onBadRequest(RegisterBadRequestResponse registerBadRequestResponse) {
    setState(() {
      _userNameErrors = registerBadRequestResponse.username?.join(' ');
      _passwordErrors = registerBadRequestResponse.password?.join(' ');
      _formKey.currentState!.validate();
    });
  }
}
