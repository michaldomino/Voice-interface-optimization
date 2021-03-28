// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();

  static S current;

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();

      return S.current;
    });
  }

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Voice interface optimization`
  String get appTitle {
    return Intl.message(
      'Voice interface optimization',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `App language`
  String get appLanguage {
    return Intl.message(
      'App language',
      name: 'appLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get en {
    return Intl.message(
      'English',
      name: 'en',
      desc: '',
      args: [],
    );
  }

  /// `Polish`
  String get pl {
    return Intl.message(
      'Polish',
      name: 'pl',
      desc: '',
      args: [],
    );
  }

  /// `Texts language`
  String get textsLanguage {
    return Intl.message(
      'Texts language',
      name: 'textsLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Custom text speaking`
  String get customTextSpeaking {
    return Intl.message(
      'Custom text speaking',
      name: 'customTextSpeaking',
      desc: '',
      args: [],
    );
  }

  /// `Predefined text speaking`
  String get predefinedTextSpeaking {
    return Intl.message(
      'Predefined text speaking',
      name: 'predefinedTextSpeaking',
      desc: '',
      args: [],
    );
  }

  /// `Voice recognition`
  String get voiceRecognition {
    return Intl.message(
      'Voice recognition',
      name: 'voiceRecognition',
      desc: '',
      args: [],
    );
  }

  /// `Recognized text:`
  String get recognizedText {
    return Intl.message(
      'Recognized text:',
      name: 'recognizedText',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginAction {
    return Intl.message(
      'Login',
      name: 'loginAction',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerAction {
    return Intl.message(
      'Register',
      name: 'registerAction',
      desc: '',
      args: [],
    );
  }

  /// `Please enter some text`
  String get pleaseEnterSomeText {
    return Intl.message(
      'Please enter some text',
      name: 'pleaseEnterSomeText',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}