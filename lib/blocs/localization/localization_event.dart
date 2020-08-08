part of 'localization_bloc.dart';

@immutable
abstract class LocalizationEvent {}

class ChangeLanguageEvent extends LocalizationEvent {
  final BuildContext context;
  final Locale localeToBeSet;

  ChangeLanguageEvent(this.context, this.localeToBeSet);
}
