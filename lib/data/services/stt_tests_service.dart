import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voice_interface_optimization/data/DTOs/requests/stt_test_result.dart';
import 'package:voice_interface_optimization/data/services/base_api_service.dart';

class SttTestsService extends BaseApiService {
  static const String _BASE_PATH = '/stt_tests/api';
  static const String _STT_TESTS_PATH = '$_BASE_PATH/stt_tests';
  static const String _STT_TEST_RESULTS_PATH = '$_BASE_PATH/stt_test_results/';

  Future<http.Response> getSttTests(String accessToken) {
    return getAuthenticatedRequest(_STT_TESTS_PATH, accessToken);
  }

  Future<http.Response> postSttTestResults(
      List<SttTestResult> ttsTestResults, String accessToken) {
    return postAuthenticatedRequest(
        json.encode(ttsTestResults), _STT_TEST_RESULTS_PATH, accessToken);
  }
}
