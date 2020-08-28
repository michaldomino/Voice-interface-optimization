import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/models/languages_codes_model.dart';

class SettingsAppLanguageSelection {
  BuildContext context;
  String _currentLanguageCode;

  SettingsAppLanguageSelection(this.context);

  get() {
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
              items: [
                DropdownMenuItem(
                  child: Text(S.of(context).english),
                  value: LanguagesCodesModel.ENGLISH,
                ),
                DropdownMenuItem(
                  child: Text(S.of(context).polish),
                  value: LanguagesCodesModel.POLISH,
                )
              ],
              onChanged: (value) => _changeLanguage(context, value),
            ),
          ),
        ]);
  }

  void _changeLanguage(BuildContext context, String targetLanguageCode) {
    // setState(() {
    BlocProvider.of<LocalizationCubit>(context)
        .changeLanguage(context, targetLanguageCode);
    _currentLanguageCode = targetLanguageCode;
    // });
  }
}

class _SettingsAppLanguageSelectionChoice {
  final String value;
  final String textCode;

  const _SettingsAppLanguageSelectionChoice(this.value, this.textCode);
}

const Map<String, String> _a = {
  'en': LanguagesCodesModel.ENGLISH,
  'pl': LanguagesCodesModel.POLISH,
};