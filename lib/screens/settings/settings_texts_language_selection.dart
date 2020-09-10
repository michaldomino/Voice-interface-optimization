import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:voice_interface_optimization/blocs/texts_language/texts_language_cubit.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/logic/text_language.dart';

import 'dropdown_with_description.dart';

class SettingsTextsLanguageSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownWithDescription(
        description: S.of(context).textsLanguage,
        initialValue: TextsLanguage().textLanguage,
        onChangedAction: (context, targetLanguageCode) {
          BlocProvider.of<TextsLanguageCubit>(context)
              .changeTextsLanguage(context, targetLanguageCode);
        },
        items: AppLocalizationDelegate()
            .supportedLocales
            .map((locale) => locale.languageCode)
            .map(
              (languageCode) => DropdownWithDescriptionItem(
                  Intl.message(languageCode), languageCode),
            )
            .toList());
  }
}
