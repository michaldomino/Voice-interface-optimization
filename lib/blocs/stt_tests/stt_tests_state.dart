part of 'stt_tests_cubit.dart';

@immutable
abstract class SttTestsState {}

class SttTestsInitial extends SttTestsState {}

class SttTestsFetching extends SttTestsState {}

class SttTestsFetchSuccessful extends SttTestsState {}

class SttTestsLoaded extends SttTestsState {
  final List<SttTest> sttTests;

  SttTestsLoaded(this.sttTests);
}

class SttTestsTokenInvalid extends SttTestsState {}

class SttTestsUnknownError extends SttTestsState {}
