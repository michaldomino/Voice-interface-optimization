import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/logic/routes_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
        title: Text(S.of(context).login),
        actions: <Widget>[
          Container(
            child: FlatButton(
                child: Text(
                  S.of(context).register,
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () =>
                    Navigator.pushNamed(context, RoutesModel.MENU)),
          ),
        ],
      ));
    });
  }
}
