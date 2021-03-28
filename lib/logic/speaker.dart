import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused, continued }

class Speaker {
  static final Speaker _instance = Speaker._();

  FlutterTts flutterTts = FlutterTts();
  dynamic languages;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;

  TtsState _ttsState = TtsState.stopped;

  get isPlaying => _ttsState == TtsState.playing;

  get isStopped => _ttsState == TtsState.stopped;

  get isPaused => _ttsState == TtsState.paused;

  get isContinued => _ttsState == TtsState.continued;

  Speaker._() {
    _initTts();
  }

  factory Speaker() {
    return _instance;
  }

  _initTts() {

    _getLanguages();

    if (!kIsWeb) {
      if (Platform.isAndroid) {
        _getEngines();
      }
    }

    flutterTts.setStartHandler(() {
      print("Playing");
      _ttsState = TtsState.playing;
    });

    flutterTts.setCompletionHandler(() {
      print("Complete");
      _ttsState = TtsState.stopped;
    });

    flutterTts.setCancelHandler(() {
      print("Cancel");
      _ttsState = TtsState.stopped;
    });

    if (kIsWeb || Platform.isIOS) {
      flutterTts.setPauseHandler(() {
        print("Paused");
        _ttsState = TtsState.paused;
      });

      flutterTts.setContinueHandler(() {
        print("Continued");
        _ttsState = TtsState.continued;
      });
    }

    flutterTts.setErrorHandler((msg) {
      print("error: $msg");
      _ttsState = TtsState.stopped;
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
  }

  Future _getEngines() async {
    var engines = await flutterTts.getEngines;
    if (engines != null) {
      for (dynamic engine in engines) {
        print(engine);
      }
    }
  }

  Future speak(String text) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (text.isNotEmpty) {
      var result = await flutterTts.speak(text);
      if (result == 1) _ttsState = TtsState.playing;
    }
  }

  Future stop() async {
    var result = await flutterTts.stop();
    if (result == 1) _ttsState = TtsState.stopped;
  }

  Future pause() async {
    var result = await flutterTts.pause();
    if (result == 1) _ttsState = TtsState.paused;
  }

  Future setLanguage(String languageCode) async {
    await flutterTts.setLanguage(languageCode);
  }

  Future dispose() async {
    await flutterTts.stop();
  }
}
