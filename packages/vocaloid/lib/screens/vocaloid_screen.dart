import 'dart:html';
import 'package:teenytinytwodee/teenytinytwodee.dart';

class VocaloidScreen implements GameScreen {
  final _textTpSpeech = TextToSpeech();
  final _timerUtil = TimerUtil();
  final logger = Logger();
  final _renderer = Renderer();
  String _said = '';

  @override
  void init() {
    _timerUtil.waitTime = 50;
  }

  @override
  void keyboard(int keyCode) {
    if (keyCode == KeyCode.A) {}
  }

  String getYolkhead() {
    const words = [
      'flamboyant',
      'yolk',
      'zebra',
      'quasar',
      'turbulent',
      'gizmo',
      'whimsical',
      'juxtapose',
      'luminescent',
      'cryptic',
      'serendipity',
      'quixotic',
      'ephemeral',
      'phantasm',
      'zenith',
    ];
    final scrambled = StringBuffer();
    final delimiter = [' ', '-', ''];

    try {
      final yolkhead = getRandomArrayElement(words) as String;

      try {
        for (int i = 0; i < yolkhead.length; i++) {
          if (getRandomBetween(1, 100) < 10) {
            final total = getRandomBetween(1, 4);

            for (int j = 0; j < total; j++) {
              scrambled.write(
                yolkhead[i] + (getRandomArrayElement(delimiter) as String),
              );
            }
          } else {
            scrambled.write(yolkhead[getRandomBetween(0, yolkhead.length)]);
          }
        }
      } catch (e) {
        scrambled.write(yolkhead);
      }

      _said = scrambled.toString();
    } catch (e) {
      scrambled.write('Yolkhead');
    }

    return scrambled.toString();
  }

  @override
  void logicLoop() {
    if (_timerUtil.hasTimePassed()) {
      _textTpSpeech.speak(
        getYolkhead(),
        rate: getRandomBetween(1, 1000) * 1.0,
        pitch: getRandomBetween(1, 1000) * 1.0,
        volume: .5,
      );

      _timerUtil.reset();
    }
  }

  @override
  void mouseClick(int x, int y, MouseButton mouseButton) {}

  @override
  void mouseMove(int x, int y) {}

  @override
  void onEnter() {}

  @override
  void onExit() {}

  @override
  void renderLoop() {
    _renderer.print(
      msg: _said,
      x: 250,
      y: 250,
      font: Font(
        color: Color(
          red: 255,
          green: 255,
          blue: 255,
        ),
        size: 25,
        family: 'Arial',
      ),
    );
  }

  @override
  // TODO: implement overLayScreens
  Map<String, GameScreenOverlay> get overLayScreens => {};
}
