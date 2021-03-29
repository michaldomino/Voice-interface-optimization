import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
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
  TextEditingController _loginEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  TextEditingController _confirmPasswordEditingController =
      TextEditingController();

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
                  child: TextFormField(
                    obscureText: true,
                    controller: _confirmPasswordEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: S.of(context).confirmPassword,
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
