import 'package:voice_interface_optimization/data/entities/tts_test.dart';

class TtsTestResult {
  final TtsTest ttsTest;
  bool result;

  TtsTestResult(this.ttsTest, this.result);

  Map<String, dynamic> toJson() => {
        'tts_test': ttsTest.id,
        'result': result,
      };
}
