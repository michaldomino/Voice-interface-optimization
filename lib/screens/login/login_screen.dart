import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
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
  TextEditingController _loginEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
      return Scaffold(
        appBar: LoginScreenAppbar(context).get(),
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
                  controller: _loginEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: S.of(context).login,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).pleaseEnterSomeText;
                    }
                    return null;
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
                      if (value == null || value.isEmpty) {
                        return S.of(context).pleaseEnterSomeText;
                      }
                      return null;
                    },
                  ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: _TOP_FORM_FIELD_MARGIN),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
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
}
