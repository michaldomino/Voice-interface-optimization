import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voice_interface_optimization/data/DTOs/requests/tts_test_result.dart';
import 'package:voice_interface_optimization/data/services/base_api_service.dart';

class TtsTestsService extends BaseApiService {
  static const String _BASE_PATH = '/tts_tests/api';
  static const String _TTS_TESTS_PATH = '$_BASE_PATH/tts_tests';
  static const String _TTS_TEST_RESULTS_PATH = '$_BASE_PATH/tts_test_results/';

  Future<http.Response> getTtsTests(String accessToken) {
    return getAuthenticatedRequest(_TTS_TESTS_PATH, accessToken);
  }

  Future<http.Response> postTtsTestResults(
      List<TtsTestResult> ttsTestResults, String accessToken) {
    return postAuthenticatedRequest(
        json.encode(ttsTestResults), _TTS_TEST_RESULTS_PATH, accessToken);
  }
}
