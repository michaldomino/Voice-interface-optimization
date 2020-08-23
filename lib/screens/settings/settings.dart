import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/models/languages_codes_model.dart';
import 'package:voice_interface_optimization/persistence/shared_preferences_wrapper.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState.getInstance();
}

class _SettingsState extends State<Settings> {
  String _currentLanguageCode;

  _SettingsState._(this._currentLanguageCode);

  static _SettingsState getInstance() {
    SharedPreferencesWrapper sharedPreferencesWrapper =
        SharedPreferencesWrapper.getInstance();
    String languageCode = sharedPreferencesWrapper.getLanguageCode();
    _SettingsState instance = _SettingsState._(languageCode);
    return instance;
  }

//  Future<String> _getCurrentLanguageCode() async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    sharedPreferences.getString(key)
//  }

//  String _currentLanguage = "pl";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).settings),
            ),
            floatingActionButton: Row(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () => _changeLanguage(context, 'en'),
                  tooltip: 'en',
                  child: Icon(Icons.add),
                  heroTag: null,
                ),
                FloatingActionButton(
                  onPressed: () => _changeLanguage(context, 'pl'),
                  tooltip: 'pl',
                  child: Icon(Icons.g_translate),
                  heroTag: null,
                )
              ],
            ));
      },
    );
  }

  void _changeLanguage(BuildContext context, String targetLanguageCode) {
    setState(() {
      BlocProvider.of<LocalizationCubit>(context).changeLanguage(
          context, Locale.fromSubtags(languageCode: targetLanguageCode));
    });
  }
}
