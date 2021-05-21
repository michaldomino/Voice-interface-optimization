part of 'tts_tests_cubit.dart';

@immutable
abstract class TtsTestsState {}

class TtsTestsInitial extends TtsTestsState {}

class TtsTestsFetching extends TtsTestsState {}

class TtsTestsFetchSuccessful extends TtsTestsState {}

class TtsTestsLoaded extends TtsTestsState {
  final List<TtsTest> ttsTests;

  TtsTestsLoaded(this.ttsTests);
}

class TtsTestsTokenInvalid extends TtsTestsState {}

class TtsTestsUnknownError extends TtsTestsState {}
