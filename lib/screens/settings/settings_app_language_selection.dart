import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';

import 'dropdown_with_description.dart';

class SettingsAppLanguageSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownWithDescription(
        description: S.of(context).appLanguage,
        initialValue: Intl.defaultLocale ?? 'en',
        onChangedAction: (context, targetLanguageCode) {
          BlocProvider.of<LocalizationCubit>(context)
              .changeAppLanguage(context, targetLanguageCode);
        },
        items: AppLocalizationDelegate()
            .supportedLocales
            .map((locale) => locale.languageCode)
            .map(
              (languageCode) => TextDropdownMenuItem(
                  Intl.message(languageCode), languageCode),
            )
            .toList());
  }
}
