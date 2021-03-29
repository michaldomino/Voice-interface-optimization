import 'package:flutter/material.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/logic/routes_model.dart';
import 'package:voice_interface_optimization/screens/reusable/custom_popup_menu_button.dart';

class LoginScreenAppbar {
  BuildContext context;

  LoginScreenAppbar(this.context);

  get() {
    return AppBar(
      title: Text(S.of(context).loginAction),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              child: Text(
                S.of(context).registerAction,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, RoutesModel.REGISTER)),
        ),
        CustomPopupMenuButton(),
      ],
    );
  }
}
