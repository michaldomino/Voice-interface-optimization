import 'package:flutter/material.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/screens/reusable/custom_popup_menu_button.dart';

class CustomAppbar {
  BuildContext context;

  CustomAppbar(this.context);

  get() {
    return AppBar(
      title: Text(S.of(this.context).appTitle),
      actions: <Widget>[
        CustomPopupMenuButton(),
      ],
    );
  }

  getTitled (String title) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        CustomPopupMenuButton(),
      ],
    );
  }
}
