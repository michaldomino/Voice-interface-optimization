import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:voice_interface_optimization/blocs/authentication/authentication_cubit.dart';
import 'package:voice_interface_optimization/blocs/texts_language/texts_language_cubit.dart';
import 'package:voice_interface_optimization/data/entities/tts_test.dart';
import 'package:voice_interface_optimization/data/services/tts_tests_service.dart';

part 'tts_tests_state.dart';

class TtsTestsCubit extends Cubit<TtsTestsState> {
  final TextsLanguageCubit textsLanguageCubit;
  final AuthenticationCubit authenticationCubit;
  final TtsTestsService ttsTestsService;
  late StreamSubscription textsLanguageSubscription;

  List<TtsTest> ttsTestList = [];

  TtsTestsCubit(
      {required this.textsLanguageCubit,
      required this.authenticationCubit,
      required this.ttsTestsService})
      : super(TtsTestsInitial()) {
    textsLanguageSubscription =
        textsLanguageCubit.stream.listen(_onTextsLanguageCubitStateChanged);
  }

  _onTextsLanguageCubitStateChanged(TextsLanguageState state) {
    if (state is TextsLanguageChanged && ttsTestList.isNotEmpty) {
      List<TtsTest> currentTextLanguageTtsTestList = ttsTestList
          .where((element) => element.language == state.language.code)
          .toList();
      emit(TtsTestsLoaded(currentTextLanguageTtsTestList));
    }
  }

  Future fetchTtsTests() async {
    emit(TtsTestsFetching());
    AuthenticationState authenticationState = authenticationCubit.state;
    if (authenticationState is AuthenticationAuthenticated) {
      var response =
          await ttsTestsService.getTtsTests(authenticationState.token.access);
      switch (response.statusCode) {
        case HttpStatus.ok:
          {
            var decodedResponseBody = Utf8Codec().decode(response.bodyBytes);
            var decodedMapList = json.decode(decodedResponseBody) as List;
            List<TtsTest> fetchedList =
                decodedMapList.map((e) => TtsTest.fromJsonMap(e)).toList();
            ttsTestList = fetchedList;
            emit(TtsTestsFetchSuccessful());
            _onTextsLanguageCubitStateChanged(textsLanguageCubit.state);
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

  @override
  Future<void> close() {
    textsLanguageSubscription.cancel();
    return super.close();
  }
}
