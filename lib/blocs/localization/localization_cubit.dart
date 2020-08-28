import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/persistence/shared_preferences_wrapper.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial());

  Future<void> changeLanguage(
      BuildContext context, Locale localeToBeSet) async {
    String targetLanguageCode = localeToBeSet.languageCode;
    if (Intl.defaultLocale != targetLanguageCode) {
      await S.load(localeToBeSet);
      SharedPreferencesWrapper sharedPreferencesWrapper =
          await SharedPreferencesWrapper.getInstance();
      await sharedPreferencesWrapper.setLanguageCode(targetLanguageCode);
      emit(LocalizationChanged());
    }
  }
}
