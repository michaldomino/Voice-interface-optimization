import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/blocs/texts_language/texts_language_cubit.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';

import 'settings_app_language_selection.dart';
import 'settings_texts_language_selection.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(title: Text(S.of(context).settings)),
            body: Column(children: <Widget>[
              SettingsAppLanguageSelection(),
              BlocBuilder<TextsLanguageCubit, TextsLanguageState>(
                  builder: (context, state) {
                return SettingsTextsLanguageSelection();
              }),
            ]));
        // )
      },
    );
  }
}
