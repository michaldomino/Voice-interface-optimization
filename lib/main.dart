import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';
import 'package:voice_interface_optimization/screens/main/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
//      routes: {
//        RoutesModel.MAIN_SCREEN: (context) =>
//            MainScreen(title: 'Flutter Demo Home Page'),
//        RoutesModel.SETTINGS: (context) => Settings()
//      },
      home: MainScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

//class RoutesModel {
//  static const String MAIN_SCREEN = '/';
//  static const String SETTINGS = '/settings';
//}
