import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';

class SettingsAppLanguageSelection extends StatefulWidget {
  @override
  _SettingsAppLanguageSelectionState createState() =>
      _SettingsAppLanguageSelectionState();
}

class _SettingsAppLanguageSelectionState
    extends State<SettingsAppLanguageSelection> {
  String _currentLanguageCode;

  @override
  void initState() {
    super.initState();
    _currentLanguageCode = Intl.defaultLocale;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            child: Text(S.of(context).appLanguage),
            flex: 1,
          ),
          Flexible(
            flex: 2,
            child: DropdownButton(
              isExpanded: true,
              value: _currentLanguageCode,
              items: AppLocalizationDelegate()
                  .supportedLocales
                  .map((locale) => locale.languageCode)
                  .map((languageCode) => DropdownMenuItem(
                        child: Text(Intl.message(languageCode)),
                        value: languageCode,
                      ))
                  .toList(),
              onChanged: (value) => _changeLanguage(context, value),
            ),
          ),
        ]);
  }

  void _changeLanguage(BuildContext context, String targetLanguageCode) {
    BlocProvider.of<LocalizationCubit>(context)
        .changeLanguage(context, targetLanguageCode);
    _currentLanguageCode = targetLanguageCode;
  }
}
