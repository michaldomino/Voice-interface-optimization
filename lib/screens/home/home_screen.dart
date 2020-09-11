import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/blocs/texts_language/texts_language_cubit.dart';
import 'package:voice_interface_optimization/logic/speaker.dart';
import 'package:voice_interface_optimization/persistence/shared_preferences_wrapper.dart';

import 'home_appbar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Speaker _speaker;
  String _textToSpeak;

  @override
  void initState() {
    super.initState();
    _speaker = Speaker();
  }

  @override
  void dispose() {
    super.dispose();
    _speaker.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
      return FutureBuilder(
        future: _loadLanguage(),
        builder: (context, _) {
          return Scaffold(
            appBar: HomeAppbarWrapper(context).get(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: TextField(
                        onChanged: (String value) {
                          setState(() {
                            _textToSpeak = value;
                          });
                        },
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.green,
                          size: 50,
                        ),
                        onTap: _playSound,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Future _loadLanguage() async {
    SharedPreferencesWrapper sharedPreferencesWrapper =
    await SharedPreferencesWrapper.getInstance();
    BlocProvider.of<LocalizationCubit>(context).changeAppLanguage(
        context, sharedPreferencesWrapper.getAppLanguageCode());
    BlocProvider.of<TextsLanguageCubit>(context).changeTextsLanguage(
        context, sharedPreferencesWrapper.getTextsLanguage());
  }

  _playSound() async {
    _speaker.speak(_textToSpeak);
  }
}
