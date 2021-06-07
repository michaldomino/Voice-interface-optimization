import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:voice_interface_optimization/blocs/authentication/authentication_cubit.dart';
import 'package:voice_interface_optimization/blocs/texts_language/texts_language_cubit.dart';
import 'package:voice_interface_optimization/data/DTOs/requests/tts_test_result.dart';
import 'package:voice_interface_optimization/data/entities/tts_test.dart';
import 'package:voice_interface_optimization/data/services/tts_tests_service.dart';

part 'tts_tests_state.dart';

class TtsTestsCubit extends Cubit<TtsTestsState> {
  final TextsLanguageCubit _textsLanguageCubit;
  final AuthenticationCubit _authenticationCubit;
  final TtsTestsService _ttsTestsService;
  late final StreamSubscription _textsLanguageSubscription;

  List<TtsTest> _ttsTestList = [];

  TtsTestsCubit(this._textsLanguageCubit, this._authenticationCubit,
      this._ttsTestsService)
      : super(TtsTestsInitial()) {
    _textsLanguageSubscription =
        _textsLanguageCubit.stream.listen(_onTextsLanguageCubitStateChanged);
  }

  Future fetchTtsTests() async {
    emit(TtsTestsFetching());
    AuthenticationState authenticationState = _authenticationCubit.state;
    if (authenticationState is AuthenticationAuthenticated) {
      var response =
          await _ttsTestsService.getTtsTests(authenticationState.token.access);
      switch (response.statusCode) {
        case HttpStatus.ok:
          {
            var decodedResponseBody = Utf8Codec().decode(response.bodyBytes);
            var decodedMapList = json.decode(decodedResponseBody) as List;
            List<TtsTest> fetchedList =
                decodedMapList.map((e) => TtsTest.fromJsonMap(e)).toList();
            _ttsTestList = fetchedList;
            emit(TtsTestsFetchSuccessful());
            _onTextsLanguageCubitStateChanged(_textsLanguageCubit.state);
          }
          break;
        case HttpStatus.unauthorized:
          {
            emit(TtsTestsTokenInvalid());
          }
          break;
        default:
          {
            emit(TtsTestsUnknownError());
          }
          break;
      }
    } else {
      emit(TtsTestsTokenInvalid());
    }
  }

  Future<List<TtsTest>?> getTtsTests() async {
    var currentState = state;
    if (currentState is TtsTestsLoaded) {
      return currentState.ttsTests;
    } else if (currentState is TtsTestsFetchSuccessful) {
      return _loadTtsTests(_textsLanguageCubit.state);
    } else {
      await fetchTtsTests();
      return _loadTtsTests(_textsLanguageCubit.state);
    }
  }

  _onTextsLanguageCubitStateChanged(TextsLanguageState textsLanguageState) {
    _loadTtsTests(textsLanguageState);
  }

  List<TtsTest>? _loadTtsTests(TextsLanguageState textsLanguageState) {
    if (textsLanguageState is TextsLanguageChanged && _ttsTestList.isNotEmpty) {
      List<TtsTest> currentTextLanguageTtsTestList = _ttsTestList
          .where(
              (element) => element.language == textsLanguageState.language.code)
          .toList();
      emit(TtsTestsLoaded(currentTextLanguageTtsTestList));
      return currentTextLanguageTtsTestList;
    }
  }

  Future sendResults(List<TtsTestResult> ttsTestResults) async {
    AuthenticationState authenticationState = _authenticationCubit.state;
    if (authenticationState is AuthenticationAuthenticated) {
      await _ttsTestsService.postTtsTestResults(
          ttsTestResults, authenticationState.token.access);
    }
  }

  @override
  Future<void> close() {
    _textsLanguageSubscription.cancel();
    return super.close();
  }
}
