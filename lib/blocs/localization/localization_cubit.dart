import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial());

  Future<void> changeLanguage(
      BuildContext context, Locale localeToBeSet) async {
    if (Intl.defaultLocale != localeToBeSet.languageCode) {
      await S.load(localeToBeSet);
      emit(LocalizationChanged());
    }
  }
}
