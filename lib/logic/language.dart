import 'package:equatable/equatable.dart';
import 'package:voice_interface_optimization/logic/value_models/languages_codes_model.dart';
import 'package:voice_interface_optimization/logic/value_models/languages_model.dart';

class Language extends Equatable {
  final String code;
  final String localizedName;

  const Language(this.code, this.localizedName);

  static Language fromLanguageCode(String? languageCode) {
    switch (languageCode) {
      case LanguagesCodesModel.POLISH:
        return LanguagesModel.POLISH;
      default:
        return LanguagesModel.ENGLISH;
    }
  }

  @override
  List<Object?> get props => [code];
}
