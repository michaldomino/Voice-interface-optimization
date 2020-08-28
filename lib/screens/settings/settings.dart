import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/models/languages_codes_model.dart';
import 'package:voice_interface_optimization/persistence/shared_preferences_wrapper.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _currentLanguageCode;

  // @override
  // Future<void> initState() async {
  //   super.initState();
  //   _currentLanguageCode = await _getCurrentLanguageCode();
  // }
  // Future<String> _currentLanguageCode = Future<String>.delayed(
  //     Duration(seconds: 2), () => _getCurrentLanguageCode());

  Future<String> _getCurrentLanguageCode() async {
    SharedPreferencesWrapper sharedPreferencesWrapper =
    await SharedPreferencesWrapper.getInstance();
    return sharedPreferencesWrapper.getLanguageCode();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        return FutureBuilder<String>(
          future: _getCurrentLanguageCode(),
          builder: (context, snapshot) {
            _currentLanguageCode = snapshot.data;
            return Scaffold(
                appBar: AppBar(
                  title: Text(S
                      .of(context)
                      .settings),
                ),
                body: Column(
                  children: <Widget>[
                    DropdownButton(
                      value: _currentLanguageCode,
                      items: [
                        DropdownMenuItem(
                          child: Text("English"),
                          value: LanguagesCodesModel.ENGLISH,
                        ),
                        DropdownMenuItem(
                          child: Text("Polish"),
                          value: LanguagesCodesModel.POLISH,
                        )
                      ],
                      onChanged: (value) => _changeLanguage(context, value),
                    )
                  ],
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
      },
    );
  }

  void _changeLanguage(BuildContext context, String targetLanguageCode) {
    // setState(() {
    BlocProvider.of<LocalizationCubit>(context).changeLanguage(
        context, Locale.fromSubtags(languageCode: targetLanguageCode));
    _currentLanguageCode = targetLanguageCode;
    // });
  }
}
