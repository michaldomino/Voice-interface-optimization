import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/logic/text_language.dart';

import 'dropdown_with_description.dart';

class SettingsTextsLanguageSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownWithDescription(
        description: "Texts language",
        initialValue: TextsLanguage.getInstance().textLanguage,
        onChangedAction: (context, targetLanguageCode) {
          TextsLanguage.getInstance().textLanguage = targetLanguageCode;
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
