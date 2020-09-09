import 'package:flutter/material.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/models/routes_model.dart';

class HomeAppbarWrapper {
  BuildContext context;

  HomeAppbarWrapper(this.context);

  static const List<_AppBarButtonChoice> _appBarButtonChoices =
      const <_AppBarButtonChoice>[
    const _AppBarButtonChoice(text: _AppBarChoicesTextModel.SETTINGS)
  ];

  void _select(BuildContext context, _AppBarButtonChoice value) {
    switch (value.text) {
      case _AppBarChoicesTextModel.SETTINGS:
        Navigator.pushNamed(context, RoutesModel.SETTINGS);
    }
  }

  get() {
    return AppBar(
      title: Text(S.of(this.context).appTitle),
      actions: <Widget>[
        PopupMenuButton(
          itemBuilder: (context) {
            return _appBarButtonChoices.map((choice) {
              return PopupMenuItem<_AppBarButtonChoice>(
                value: choice,
                child: Text(choice.text),
              );
            }).toList();
          },
          onSelected: (choice) => _select(context, choice),
        )
      ],
    );
  }
}

class _AppBarButtonChoice {
  const _AppBarButtonChoice({this.text});

  final String text;
}

class _AppBarChoicesTextModel {
  static const SETTINGS = 'Settings';
}
