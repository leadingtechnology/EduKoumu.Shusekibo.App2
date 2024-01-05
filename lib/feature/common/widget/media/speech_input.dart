import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';


class SpeechInput extends StatefulWidget {
  const SpeechInput({required this.kizukiController,super.key});

  final TextEditingController kizukiController;
  
  @override
  SpeechInputState createState() => SpeechInputState();
}

/// An example that demonstrates the basic functionality of the
/// SpeechToText plugin for using the speech recognition capability
/// of the underlying platform.
class SpeechInputState extends State<SpeechInput> {
  bool _hasSpeech = false;
  bool _logEvents = false;
  bool _onDevice = false;

  // １分間３００文字まで
  final _pauseForController = TextEditingController(text: '60');
  final _listenForController = TextEditingController(text: '60');

  double level = 0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  final String _currentLocaleId = 'ja';
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();

    // 非同期処理initSpeechStateを呼び出す
    initSpeechState();

    startListening();
  }

  /// This initializes SpeechToText. That only has to be done
  /// once per application, though calling it again is harmless
  /// it also does nothing. The UX of the sample app ensures that
  /// it can only be called once.
  Future<void> initSpeechState() async {
    _logEvent('Initialize');
    try {
      final hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: _logEvents,
      );
      if (!mounted) return;

      setState(() {
        _hasSpeech = hasSpeech;
      });
    } catch (e) {
      setState(() {
        lastError = 'Speech recognition failed: $e';
        _hasSpeech = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        title: const Text('音声入力'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ColoredBox(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            Column(
              children: <Widget>[
                SpeechControlWidget(
                  _hasSpeech,
                  speech.isListening,
                  startListening,
                  stopListening,
                  cancelListening,
                ),
                SessionOptionsWidget(
                  _logEvents,
                  _switchLogging,
                  _pauseForController,
                  _listenForController,
                  _onDevice,
                  _switchOnDevice,
                ),
              ],
            ),
            Expanded(
              flex: 4,
              child:
                  RecognitionResultsWidget(lastWords: lastWords, level: level),
            ),
            // Expanded(
            //   child: ErrorWidget(lastError: lastError),
            // ),
            SpeechStatusWidget(speech: speech),
          ],
        ),
      ),
    );
  }

  // This is called each time the users wants to start a new speech
  // recognition session
  void startListening() {
    _logEvent('start listening');
    lastWords = '';
    lastError = '';
    final pauseFor = int.tryParse(_pauseForController.text);
    final listenFor = int.tryParse(_listenForController.text);
    // Note that `listenFor` is the maximum, not the minimum, on some
    // systems recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: listenFor ?? 60),
      pauseFor: Duration(seconds: pauseFor ?? 60),
      // partialResults: true,
      localeId: _currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      cancelOnError: true,
      // listenMode: ListenMode.confirmation,
      onDevice: _onDevice,
    );
    setState(() {});
  }

  void stopListening() {
    _logEvent('stop');
    speech.stop();
    setState(() {
      level = 0.0;
    });

    widget.kizukiController.text = widget.kizukiController.text + lastWords;
    
    Navigator.of(context).pop();
  }

  void cancelListening() {
    _logEvent('cancel');
    speech.cancel();
    setState(() {
      lastWords = '';
      level = 0.0;
    });

  }

  /// This callback is invoked each time new recognition results are
  /// available after `listen` is called.
  void resultListener(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      //lastWords = '${result.recognizedWords} - ${result.finalResult}';
      lastWords = result.recognizedWords;
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = status;
    });
  }

  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      debugPrint('$eventTime $eventDescription');
    }
  }

  void _switchLogging(bool? val) {
    setState(() {
      _logEvents = val ?? false;
    });
  }

  void _switchOnDevice(bool? val) {
    setState(() {
      _onDevice = val ?? false;
    });
  }
}

/// Displays the most recently recognized words and the sound level.
class RecognitionResultsWidget extends StatelessWidget {
  const RecognitionResultsWidget({
    required this.lastWords, required this.level, super.key,
  });

  final String lastWords;
  final double level;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                color: Theme.of(context).secondaryHeaderColor,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 150),
                  child: Text(
                    lastWords,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                right: 20,
                top: 10,
                child: Text('文字数: ${lastWords.length}'),
              ),
              Positioned.fill(
                bottom: 10,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: .26,
                            spreadRadius: level * 1.5,
                            color: Colors.black.withOpacity(.05),),
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.mic),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '音声入力',
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}

/// Display the current error status from the speech
/// recognizer
class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    required this.lastError, super.key,
  });

  final String lastError;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Center(
          child: Text(
            'Error Status',
            style: TextStyle(fontSize: 22),
          ),
        ),
        Center(
          child: Text(lastError),
        ),
      ],
    );
  }
}

/// Controls to start and stop speech recognition
class SpeechControlWidget extends StatelessWidget {
  const SpeechControlWidget(this.hasSpeech, this.isListening,
      this.startListening, this.stopListening, this.cancelListening,
      {super.key,});

  final bool hasSpeech;
  final bool isListening;
  final void Function() startListening;
  final void Function() stopListening;
  final void Function() cancelListening;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TextButton(
          onPressed: !hasSpeech || isListening ? null : startListening,
          child: const Text('開始'),
        ),
        TextButton(
          onPressed: isListening ? stopListening : null,
          child: const Text('確定'),
        ),
        TextButton(
          onPressed: isListening ? cancelListening : null,
          child: const Text('キャンセル'),
        ),
      ],
    );
  }
}

class SessionOptionsWidget extends StatelessWidget {
  const SessionOptionsWidget(
      this.logEvents,
      this.switchLogging,
      this.pauseForController,
      this.listenForController,
      this.onDevice,
      this.switchOnDevice,
      {super.key,});

  final void Function(bool?) switchLogging;
  final void Function(bool?) switchOnDevice;
  final TextEditingController pauseForController;
  final TextEditingController listenForController;
  final bool logEvents;
  final bool onDevice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              const Text('待機秒数: '),
              Container(
                  padding: const EdgeInsets.only(left: 8),
                  width: 45,
                  child: TextFormField(
                    controller: pauseForController,
                  ),),
              const Text('秒',),
              MySpacing.width(20),
              Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: const Text('入力秒数: '),),
              Container(
                  padding: const EdgeInsets.only(left: 8),
                  width: 45,
                  child: TextFormField(
                    controller: listenForController,
                  ),),
              const Text('秒',),
            ],
          ),
          // Row(
          //   children: [
          //     const Text('On device: '),
          //     Checkbox(
          //       value: onDevice,
          //       onChanged: switchOnDevice,
          //     ),
          //     const Text('Log events: '),
          //     Checkbox(
          //       value: logEvents,
          //       onChanged: switchLogging,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

/// Display the current status of the listener
class SpeechStatusWidget extends StatelessWidget {
  const SpeechStatusWidget({
    required this.speech, super.key,
  });

  final SpeechToText speech;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: speech.isListening
            ? const Text(
                '聞いています...',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : const Text(
                '停止中...',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
