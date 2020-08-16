import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/screens/main/main_screen.dart';
import 'package:voice_interface_optimization/screens/settings/settings.dart';

import 'blocs/localization/localization_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LocalizationBloc(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
//        GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          routes: {
            RoutesModel.MAIN_SCREEN: (context) =>
                MainScreen(title: 'Flutter Demo Home Page'),
            RoutesModel.SETTINGS: (context) => Settings()
          },
          initialRoute: RoutesModel.MAIN_SCREEN,
//          home: MainScreen(title: 'Flutter Demo Home Page'),
//          home: BlocProvider(
//            create: (context) => LocalizationBloc(),
//            child: MainScreen(title: 'Flutter Demo Home Page'),
//          )),
        ));
  }
}

class RoutesModel {
  static const String MAIN_SCREEN = '/';
  static const String SETTINGS = '/settings';
}
