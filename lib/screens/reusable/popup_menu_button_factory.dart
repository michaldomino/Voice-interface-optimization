import 'package:flutter/material.dart';
import 'package:voice_interface_optimization/screens/reusable/custom_popup_menu_button.dart';
import 'package:voice_interface_optimization/screens/reusable/popup_menu_button_choice.dart';

class PopupMenuButtonFactory {
  final BuildContext context;
  late final _AuthenticatedPopupMenuButton authenticated;
  late final _UnauthenticatedPopupMenuButton unauthenticated;

  PopupMenuButtonFactory(this.context) {
    authenticated = _AuthenticatedPopupMenuButton(context);
    unauthenticated = _UnauthenticatedPopupMenuButton(context);
  }
}

abstract class _BasePopupMenuButton {
  final BuildContext context;
  final List<PopupMenuButtonChoice> _appBarButtonChoices;

  _BasePopupMenuButton(this.context, this._appBarButtonChoices);

  get() {
    return CustomPopupMenuButton(_appBarButtonChoices);
  }
}

class _AuthenticatedPopupMenuButton extends _BasePopupMenuButton {
  final BuildContext context;

  _AuthenticatedPopupMenuButton(this.context)
      : super(context, [
          const PopupMenuButtonChoice(PopupMenuChoicesTextModel.SETTINGS),
          const PopupMenuButtonChoice(PopupMenuChoicesTextModel.LOG_OUT),
        ]);
}

class _UnauthenticatedPopupMenuButton extends _BasePopupMenuButton {
  final BuildContext context;

  _UnauthenticatedPopupMenuButton(this.context)
      : super(context, [
          const PopupMenuButtonChoice(PopupMenuChoicesTextModel.SETTINGS),
        ]);
}
