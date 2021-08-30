import 'package:flutter/material.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/screens/reusable/popup_menu_button_factory.dart';

class CustomAppBar {
  final BuildContext context;

  CustomAppBar(this.context);

  get() {
    return AppBar(
      title: Text(S.of(this.context).appTitle),
      actions: <Widget>[
        PopupMenuButtonFactory(context).authenticated.get(),
      ],
    );
  }

  getTitled(String title) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        PopupMenuButtonFactory(context).authenticated.get(),
      ],
    );
  }
}
