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
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
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

  /// `French`
  String get fr {
    return Intl.message(
      'French',
      name: 'fr',
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

  /// `Confirm password`
  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
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

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Account created successfully`
  String get accountCreatedSuccessfully {
    return Intl.message(
      'Account created successfully',
      name: 'accountCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Server is down`
  String get serverIsDown {
    return Intl.message(
      'Server is down',
      name: 'serverIsDown',
      desc: '',
      args: [],
    );
  }

  /// `Text-to-Speech test`
  String get ttsTest {
    return Intl.message(
      'Text-to-Speech test',
      name: 'ttsTest',
      desc: '',
      args: [],
    );
  }

  /// `Speech-to-Text test`
  String get sttTest {
    return Intl.message(
      'Speech-to-Text test',
      name: 'sttTest',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous {
    return Intl.message(
      'Previous',
      name: 'previous',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logOut {
    return Intl.message(
      'Log out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to send the results?`
  String get doYouWantToSendTheResults {
    return Intl.message(
      'Do you want to send the results?',
      name: 'doYouWantToSendTheResults',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for participating in the study`
  String get thankYouForParticipatingInTheStudy {
    return Intl.message(
      'Thank you for participating in the study',
      name: 'thankYouForParticipatingInTheStudy',
      desc: '',
      args: [],
    );
  }

  /// `You are not verified yet`
  String get youAreNotVerifiedYet {
    return Intl.message(
      'You are not verified yet',
      name: 'youAreNotVerifiedYet',
      desc: '',
      args: [],
    );
  }

  /// `Click the button to play the text and check if the text is clearly audible`
  String get isTextClearlyAudible {
    return Intl.message(
      'Click the button to play the text and check if the text is clearly audible',
      name: 'isTextClearlyAudible',
      desc: '',
      args: [],
    );
  }

  /// `(Click the button to record the voice)`
  String get clickTheButtonToRecordTheVoice {
    return Intl.message(
      '(Click the button to record the voice)',
      name: 'clickTheButtonToRecordTheVoice',
      desc: '',
      args: [],
    );
  }

  /// `Please set the volume to maximum`
  String get pleaseSetTheVolumeToMaximum {
    return Intl.message(
      'Please set the volume to maximum',
      name: 'pleaseSetTheVolumeToMaximum',
      desc: '',
      args: [],
    );
  }

  /// `Instruction`
  String get instruction {
    return Intl.message(
      'Instruction',
      name: 'instruction',
      desc: '',
      args: [],
    );
  }

  /// `The study consists of two tests that are available from the menu.\n\nIn the first test (Text-to-Speech Test), play the statement and then select whether it is clearly audible.\n\nIn the second test (Speech-to-Text Test), you should record the phrase written above the button. Press the microphone button to record your speech.\n\nAll steps must be completed to pass the test. The steps can be done in any order. If a test step is passed, a checkmark appears instead of the step number. After completing all steps, a button will appear allowing you to send the results.`
  String get instructionContent {
    return Intl.message(
      'The study consists of two tests that are available from the menu.\n\nIn the first test (Text-to-Speech Test), play the statement and then select whether it is clearly audible.\n\nIn the second test (Speech-to-Text Test), you should record the phrase written above the button. Press the microphone button to record your speech.\n\nAll steps must be completed to pass the test. The steps can be done in any order. If a test step is passed, a checkmark appears instead of the step number. After completing all steps, a button will appear allowing you to send the results.',
      name: 'instructionContent',
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
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
