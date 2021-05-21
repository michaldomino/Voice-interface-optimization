part of 'texts_language_cubit.dart';

@immutable
abstract class TextsLanguageState {}

class TextsLanguageInitial extends TextsLanguageState {}

class TextsLanguageChanged extends TextsLanguageState {
  final Language language;

  TextsLanguageChanged(this.language);
}
