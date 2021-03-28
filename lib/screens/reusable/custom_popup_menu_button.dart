import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:voice_interface_optimization/logic/routes_model.dart';

class CustomPopupMenuButton extends StatelessWidget {
  static const List<_PopupMenuButtonChoice> _appBarButtonChoices =
      const <_PopupMenuButtonChoice>[
    const _PopupMenuButtonChoice(text: _PopupMenuChoicesTextModel.SETTINGS)
  ];

  void _select(BuildContext context, _PopupMenuButtonChoice value) {
    switch (value.text) {
      case _PopupMenuChoicesTextModel.SETTINGS:
        Navigator.pushNamed(context, RoutesModel.SETTINGS);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return _appBarButtonChoices.map((choice) {
          return PopupMenuItem<_PopupMenuButtonChoice>(
            value: choice,
            child: Text(Intl.message((choice.text))),
          );
        }).toList();
      },
      onSelected: (choice) => _select(context, choice),
    );
  }
}

class _PopupMenuButtonChoice {
  const _PopupMenuButtonChoice({this.text});

  final String text;
}

class _PopupMenuChoicesTextModel {
  static const SETTINGS = 'settings';
}
