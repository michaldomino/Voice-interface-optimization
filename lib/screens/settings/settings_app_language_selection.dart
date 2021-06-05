import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/logic/language.dart';
import 'package:voice_interface_optimization/logic/value_models/languages_model.dart';

import 'dropdown_with_description.dart';

class SettingsAppLanguageSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownWithDescription<Language>(
        description: S.of(context).appLanguage,
        initialValue: Language.fromLanguageCode(Intl.defaultLocale),
        onChangedAction: (context, targetLanguageCode) {
          BlocProvider.of<LocalizationCubit>(context)
              .changeAppLanguage(context, targetLanguageCode);
        },
        items: LanguagesModel.supportedLanguages
            .map(
              (language) =>
                  TextDropdownMenuItem(language.localizedName, language),
            )
            .toList());
  }
}
