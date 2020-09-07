import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/persistence/shared_preferences_wrapper.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial());

  Future changeLanguage(BuildContext context, String languageCode) async {
    if (Intl.defaultLocale != languageCode) {
      await S.load(Locale.fromSubtags(languageCode: languageCode));
      SharedPreferencesWrapper sharedPreferencesWrapper =
          await SharedPreferencesWrapper.getInstance();
      await sharedPreferencesWrapper.setLanguageCode(languageCode);
      emit(LocalizationChanged());
    }
  }
}
