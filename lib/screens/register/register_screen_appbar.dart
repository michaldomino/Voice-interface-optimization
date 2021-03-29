import 'package:flutter/material.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/screens/reusable/custom_popup_menu_button.dart';

class RegisterScreenAppbar {
  BuildContext context;

  RegisterScreenAppbar(this.context);

  get() {
    return AppBar(
      title: Text(S.of(context).registerAction),
      actions: <Widget>[
        CustomPopupMenuButton(),
      ],
    );
  }
}
