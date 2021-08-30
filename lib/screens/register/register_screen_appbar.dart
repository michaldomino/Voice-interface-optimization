import 'package:flutter/material.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/screens/reusable/popup_menu_button_factory.dart';

class RegisterScreenAppbar {
  BuildContext context;

  RegisterScreenAppbar(this.context);

  get() {
    return AppBar(
      title: Text(S.of(context).registerAction),
      actions: <Widget>[
        PopupMenuButtonFactory(context).unauthenticated.get(),
      ],
    );
  }
}
