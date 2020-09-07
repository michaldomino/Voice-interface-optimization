import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/logic/speaker.dart';
import 'package:voice_interface_optimization/persistence/shared_preferences_wrapper.dart';
import 'package:voice_interface_optimization/screens/main/main_appbar.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Speaker speaker;

  @override
  void initState() {
    super.initState();
    speaker = Speaker.getInstance();
  }

  @override
  void dispose() {
    super.dispose();
    speaker.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
      return FutureBuilder(
        future: _loadLanguage(),
        builder: (context, _) {
          return Scaffold(
            appBar: MainAppbarWrapper(context).get(),
            body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'You have pushed the button this many times:',
                      ),
                      IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: _playSound,
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
    String languageCode = sharedPreferencesWrapper.getLanguageCode();
    BlocProvider.of<LocalizationCubit>(context)
        .changeLanguage(context, languageCode);
  }

  _playSound() async {
    speaker.speak("Test sound");
  }
}
