import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/persistence/shared_preferences_wrapper.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial());

  Future changeAppLanguage(BuildContext context, String languageCode) async {
    if (Intl.defaultLocale != languageCode) {
      await S.load(Locale.fromSubtags(languageCode: languageCode));
      SharedPreferencesWrapper sharedPreferencesWrapper =
          await SharedPreferencesWrapper.getInstance();
      await sharedPreferencesWrapper.setAppLanguageCode(languageCode);
      emit(LocalizationChanged());
    }
  }
}
