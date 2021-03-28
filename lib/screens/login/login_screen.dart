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

class _LoginScreenState extends State {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
      return Scaffold(
        appBar: LoginScreenAppbar(context).get(),
        body: Container(
          margin: EdgeInsets.only(left: 30.0, right: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: S.of(context).login,
                    ),
                    validator: (String value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).pleaseEnterSomeText;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: S.of(context).password,
                    ),
                    validator: (String value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).pleaseEnterSomeText;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}
                    },
                    child: const Text('Submit'),
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
