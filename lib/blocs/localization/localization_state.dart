part of 'localization_cubit.dart';

@immutable
abstract class LocalizationState {}

class LocalizationInitial extends LocalizationState {}

class LocalizationChanged extends LocalizationState {
  final Language language;

  LocalizationChanged(this.language);
}
