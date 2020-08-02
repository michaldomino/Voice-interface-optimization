import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:voice_interface_optimization/screens/main/main_screen.dart';
import 'package:voice_interface_optimization/screens/settings/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('pl', ''),
      ],
      routes: {
        RoutesModel.MAIN_SCREEN: (context) =>
            MainScreen(title: 'Flutter Demo Home Page'),
        RoutesModel.SETTINGS: (context) => Settings()
      },
      initialRoute: RoutesModel.MAIN_SCREEN,
    );
  }
}

class RoutesModel {
  static const String MAIN_SCREEN = '/';
  static const String SETTINGS = '/settings';
}
