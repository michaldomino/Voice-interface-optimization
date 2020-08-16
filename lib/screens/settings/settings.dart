import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_bloc.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';

class Settings extends StatefulWidget {

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
            floatingActionButton: Row(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () => _changeLanguage(context, 'en'),
                  tooltip: 'en',
                  child: Icon(Icons.add),
                  heroTag: null,
                ),
                FloatingActionButton(
                  onPressed: () => _changeLanguage(context, 'pl'),
                  tooltip: 'pl',
                  child: Icon(Icons.g_translate),
                  heroTag: null,
                )
              ],
            ));
      },
    );
  }

  void _changeLanguage(BuildContext context, String targetLanguageCode) {
    setState(() {
//      String targetLanguageCode;
//      if (Intl.defaultLocale == 'en') {
//        targetLanguageCode = 'pl';
//      } else {
//        targetLanguageCode = 'en';
//      }
      BlocProvider.of<LocalizationBloc>(context)
          .add(ChangeLanguageEvent(context, Locale(targetLanguageCode)));
    });
  }
}
