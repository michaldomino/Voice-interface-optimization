import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';

class Settings extends StatefulWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Settings"),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: (context) {_changeLanguage(context)},
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ),
//    );
//  }

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _changeLanguage(context),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _changeLanguage(BuildContext context) {
    setState(() {
      String targetLanguageCode;
      if (Intl.defaultLocale == 'en') {
        targetLanguageCode = 'pl';
      } else {
        targetLanguageCode = 'en';
      }
      S.load(Locale(targetLanguageCode));
      Intl.defaultLocale = targetLanguageCode;
    });
  }
}
