import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_bloc.dart';
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
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, state) {
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
      },
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
      BlocProvider.of<LocalizationBloc>(context)
          .add(ChangeLanguageEvent(context, Locale(targetLanguageCode)));
    });
  }
}
