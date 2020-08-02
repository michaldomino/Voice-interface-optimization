import 'package:flutter/material.dart';
import 'package:voice_interface_optimization/main.dart';
import 'package:voice_interface_optimization/screens/main/main_screen.dart';

class MainScreenAppBar extends StatelessWidget {
  final MyHomePage widget;

  const MainScreenAppBar(this.widget);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: Text(widget.title),
      actions: <Widget>[
        PopupMenuButton(
          itemBuilder: (context) {
            return appBarButtonChoices.map((choice) {
              return PopupMenuItem<AppBarButtonChoice>(
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

  void _select(BuildContext context, AppBarButtonChoice value) {
    switch (value.text) {
      case "Settings":
        Navigator.pushNamed(context, RoutesModel.SETTINGS);
//            context, MaterialPageRoute(builder: (context) => Settings()));
    }
  }
}

class AppBarButtonChoice {
  const AppBarButtonChoice({this.text});

  final String text;
}

const List<AppBarButtonChoice> appBarButtonChoices = const <AppBarButtonChoice>[
  const AppBarButtonChoice(text: "Settings")
];
