import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:voice_interface_optimization/blocs/authentication/authentication_cubit.dart';
import 'package:voice_interface_optimization/blocs/texts_language/texts_language_cubit.dart';
import 'package:voice_interface_optimization/data/DTOs/requests/stt_test_result.dart';
import 'package:voice_interface_optimization/data/entities/stt_test.dart';
import 'package:voice_interface_optimization/data/services/stt_tests_service.dart';

part 'stt_tests_state.dart';

class SttTestsCubit extends Cubit<SttTestsState> {
  final TextsLanguageCubit _textsLanguageCubit;
  final AuthenticationCubit _authenticationCubit;
  final SttTestsService _sttTestsService;
  late final StreamSubscription _textsLanguageSubscription;

  List<SttTest> _sttTestList = [];

  SttTestsCubit(this._textsLanguageCubit, this._authenticationCubit,
      this._sttTestsService)
      : super(SttTestsInitial()) {
    _textsLanguageSubscription =
        _textsLanguageCubit.stream.listen(_onTextsLanguageCubitStateChanged);
  }

  Future fetchSttTests() async {
    emit(SttTestsFetching());
    AuthenticationState authenticationState = _authenticationCubit.state;
    if (authenticationState is AuthenticationAuthenticated) {
      var response =
          await _sttTestsService.getSttTests(authenticationState.token.access);
      switch (response.statusCode) {
        case HttpStatus.ok:
          {
            var decodedResponseBody = Utf8Codec().decode(response.bodyBytes);
            var decodedMapList = json.decode(decodedResponseBody) as List;
            List<SttTest> fetchedList =
                decodedMapList.map((e) => SttTest.fromJsonMap(e)).toList();
            _sttTestList = fetchedList;
            emit(SttTestsFetchSuccessful());
            _onTextsLanguageCubitStateChanged(_textsLanguageCubit.state);
          }
          break;
        case HttpStatus.unauthorized:
          {
            emit(SttTestsTokenInvalid());
          }
          break;
        default:
          {
            emit(SttTestsUnknownError());
          }
          break;
      }
    } else {
      emit(SttTestsTokenInvalid());
    }
  }

  Future<List<SttTest>?> getSttTests() async {
    var currentState = state;
    if (currentState is SttTestsLoaded) {
      return currentState.sttTests;
    } else if (currentState is SttTestsFetchSuccessful) {
      return _loadSttTests(_textsLanguageCubit.state);
    } else {
      await fetchSttTests();
      return _loadSttTests(_textsLanguageCubit.state);
    }
  }

  _onTextsLanguageCubitStateChanged(TextsLanguageState textsLanguageState) {
    _loadSttTests(textsLanguageState);
  }

  List<SttTest>? _loadSttTests(TextsLanguageState textsLanguageState) {
    if (textsLanguageState is TextsLanguageChanged && _sttTestList.isNotEmpty) {
      List<SttTest> currentTextLanguageSttTestList = _sttTestList
          .where(
              (element) => element.language == textsLanguageState.language.code)
          .toList();
      currentTextLanguageSttTestList
          .sort((a, b) => a.text.length.compareTo(b.text.length));
      emit(SttTestsLoaded(currentTextLanguageSttTestList));
      return currentTextLanguageSttTestList;
    }
  }

  Future sendResults(List<SttTestResult> sttTestResults) async {
    AuthenticationState authenticationState = _authenticationCubit.state;
    if (authenticationState is AuthenticationAuthenticated) {
      await _sttTestsService.postSttTestResults(
          sttTestResults, authenticationState.token.access);
    }
  }

  @override
  Future<void> close() {
    _textsLanguageSubscription.cancel();
    return super.close();
  }
}
