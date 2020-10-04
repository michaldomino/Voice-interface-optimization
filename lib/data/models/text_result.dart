import 'package:voice_interface_optimization/data/models/predefined_text.dart';

class TextResult {
  final PredefinedText text;
  final double volume;
  final double pitch;
  final double rate;

  TextResult(this.text, this.volume, this.pitch, this.rate);

  Map<String, dynamic> toJson() => {
        'text': text.id,
        'volume': volume,
        'pitch': pitch,
        'rate': rate,
      };
}
