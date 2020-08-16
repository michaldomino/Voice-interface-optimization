import 'package:flutter/material.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/screens/settings/settings.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _select(BuildContext context, AppBarButtonChoice value) {
    switch (value.text) {
      case "Settings":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Settings()),
        ).then((value) => setState(() {}));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
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
//            onSelected: (choice) => _changeLanguage(context),
            onSelected: (choice) => _select(context, choice),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
//        onPressed: () => _changeLanguage(context),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class AppBarButtonChoice {
  const AppBarButtonChoice({this.text});

  final String text;
}

const List<AppBarButtonChoice> appBarButtonChoices = const <AppBarButtonChoice>[
  const AppBarButtonChoice(text: "Settings")
];
