import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(LocalizationInitial());

  @override
  Stream<LocalizationState> mapEventToState(
    LocalizationEvent event,
  ) async* {
    if (event is ChangeLanguageEvent) {
      Locale localeToBeSet = event.localeToBeSet;
      if (Intl.defaultLocale != localeToBeSet.languageCode) {
        await S.load(localeToBeSet);
        yield LocalizationChanged();
      }
    }
  }
}
