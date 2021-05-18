import 'package:http/http.dart' as http;
import 'package:voice_interface_optimization/data/services/base_api_service.dart';

class TtsTestsService extends BaseApiService {
  static const String _TTS_TESTS_PATH = '/tts_tests/api/tts_tests';

  Future<http.Response> getTtsTests(String accessToken) {
    return getPrivateRequest(_TTS_TESTS_PATH, accessToken);
  }
}
