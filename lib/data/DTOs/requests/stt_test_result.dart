import 'package:voice_interface_optimization/data/entities/stt_test.dart';

class SttTestResult {
  final SttTest sttTest;
  String result;

  SttTestResult(this.sttTest, this.result);

  Map<String, dynamic> toJson() => {
        'stt_test': sttTest.id,
        'result': result,
      };
}
