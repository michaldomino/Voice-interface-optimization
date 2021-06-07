import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:voice_interface_optimization/blocs/texts_language/texts_language_cubit.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/logic/language.dart';
import 'package:voice_interface_optimization/logic/value_models/languages_model.dart';

import 'dropdown_with_description.dart';

class SettingsTextsLanguageSelection extends StatefulWidget {
  @override
  _SettingsTextsLanguageSelectionState createState() =>
      _SettingsTextsLanguageSelectionState();
}

class _SettingsTextsLanguageSelectionState
    extends State<SettingsTextsLanguageSelection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextsLanguageCubit, TextsLanguageState>(
        builder: (context, state) {
      if (state is TextsLanguageChanged) {
        return DropdownWithDescription<Language>(
            description: S.of(context).textsLanguage,
            initialValue: state.language,
            onChangedAction: (targetLanguage) {
              BlocProvider.of<TextsLanguageCubit>(context)
                  .changeTextsLanguage(context, targetLanguage);
            },
            items: LanguagesModel.supportedLanguages
                .map((language) =>
                    TextDropdownMenuItem(Intl.message(language.code), language))
                .toList());
      } else {
        return CircularProgressIndicator();
      }
    });
  }
}
