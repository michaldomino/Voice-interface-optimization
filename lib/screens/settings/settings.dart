import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/screens/settings/dropdown_with_description.dart';

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
              DropdownWithDescription(
                  description: S.of(context).appLanguage,
                  initialValue: Intl.defaultLocale,
                  onChanged: (context, targetLanguageCode) {
                    BlocProvider.of<LocalizationCubit>(context)
                        .changeLanguage(context, targetLanguageCode);
                  },
                  items: AppLocalizationDelegate()
                      .supportedLocales
                      .map((locale) => locale.languageCode)
                      .map(
                        (languageCode) => DropdownWithDescriptionItem(
                            Intl.message(languageCode), languageCode),
                      )
                      .toList())
              // SettingsAppLanguageSelection(),
              // SettingsTextsLanguageSelection(),
            ]));
        // )
      },
    );
  }
}
