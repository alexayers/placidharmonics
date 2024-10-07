import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/application/game_screen_overlay.dart';
import 'package:teenytinytwodee/input/mouse.dart';
import 'package:teenytinytwodee/logger/logger.dart';
import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/rendering/animated_sprite.dart';
import 'package:teenytinytwodee/rendering/font.dart';
import 'package:teenytinytwodee/rendering/particle.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';
import 'package:teenytinytwodee/utils/html_utils.dart';
import 'package:teenytinytwodee/utils/math_utils.dart';
import 'package:teenytinytwodee/utils/timer_util.dart';
import 'package:test_bed/styles/adjective_styles.dart';
import 'package:test_bed/styles/full_styles.dart';
import 'package:test_bed/styles/partial_styles.dart';
import 'package:test_bed/styles/prefix_styles.dart';
import 'package:test_bed/styles/suffix_styles.dart';

class MainScreen implements GameScreen {
  final _renderer = Renderer();
  final Logger _logger = Logger();
  final StringBuffer _tokens = StringBuffer();
  bool _isAlexMakingMagic = false;
  int letterTicker = 0;
  late final AnimatedSprite _alexImage;
  final List<Particle> particles = [];
  final TimerUtil _timerUtil = TimerUtil();
  final ParticleRenderer _particleRenderer = ParticleRenderer();

  @override
  void init() {
    _alexImage = AnimatedSprite(
      imageFiles: {
        'default': [
          'assets/images/alex1.png',
        ],
        'active': [
          'assets/images/alex2.png',
        ],
      },
      currentAction: 'default',
    );

    _timerUtil.waitTime = 25;

    for (int i = 0; i < 1000; i++) {
      particles.add(_particleRefresh());
    }
  }

  String _goofyIt(String prompt) {
    return getRandomBetween(1, 10) < 5 ? '[$prompt]' : '($prompt)';
  }

  @override
  void keyboard(int keyCode) {
    switch (keyCode) {
      case 65:
        if (!_isAlexMakingMagic) {
          _timerUtil.start();
          letterTicker = 0;
          _generatePrompt();
          _isAlexMakingMagic = true;
        }
      case 67:
        copyToClipboard(
          _tokens.toString(),
        );
    }
  }

  void _generatePrompt() {
    final totalComponents = getRandomBetween(3, 5);
    final delimiters = [' ', ',', ';', '+', '|'];

    _logger.info('Total components: $totalComponents');
    _tokens.clear();

    for (int i = 0; i < totalComponents; i++) {
      String temp = '';

      if (getRandomBetween(1, 100) < 10) {
        temp += getRandomArrayElement(adjectiveStyles) as String;
        temp += getRandomArrayElement(prefixStyles) as String;
        temp += getRandomArrayElement(partialStyles) as String;
        temp += getRandomArrayElement(suffixStyles) as String;
      } else {
        temp += getRandomArrayElement(fullStyles) as String;
      }

      if (getRandomBetween(1, 100) < 5) {
        temp = _goofyIt(temp);
      }

      _tokens.write(temp);

      if (i < totalComponents - 1) {
        _tokens.write(getRandomArrayElement(delimiters) as String);
      }
    }

    _alexImage.currentAction = 'active';

    _logger.info('Prompt: $_tokens');
  }

  @override
  void logicLoop() {}

  @override
  void mouseClick(double x, double y, MouseButton mouseButton) {}

  @override
  void mouseMove(double x, double y) {}

  @override
  void onEnter() {}

  @override
  void onExit() {}

  @override
  void renderLoop() {
    _renderer.clearScreen(Color(red: 210, green: 217, blue: 202));

    if (!_isAlexMakingMagic) {
      _renderer.print(
        msg: 'PROMPT MAGIC',
        x: 250,
        y: 100,
        font: Font(
          family: 'Arial',
          size: 25,
          color: Color(
            red: 166,
            green: 164,
            blue: 153,
          ),
        ),
      );

      _renderer.print(
        msg: 'Press "a" to generate a prompt',
        x: 20,
        y: _renderer.getCanvasHeight() - 100,
        font: Font(
          family: 'Arial',
          size: 15,
          color: Color(
            red: 166,
            green: 164,
            blue: 153,
          ),
        ),
      );

      _renderer.print(
        msg: 'Press "c" to copy prompt to clipboard',
        x: 20,
        y: _renderer.getCanvasHeight() - 80,
        font: Font(
          family: 'Tahoma',
          size: 15,
          color: Color(
            red: 166,
            green: 164,
            blue: 153,
          ),
        ),
      );
    } else {
      _particleRenderer.render(particles, _particleRefresh);

      if (letterTicker < _tokens.length) {
        _renderer.print(
          msg: _tokens.toString()[letterTicker],
          x: 200,
          y: 400,
          font: Font(
            family: 'Arial',
            size: 700,
            color: Color(
              red: getRandomBetween(1, 255),
              green: getRandomBetween(1, 255),
              blue: getRandomBetween(1, 255),
              alpha: 0.50 - _timerUtil.getPercentRemaing(),
            ),
          ),
        );

        if (_timerUtil.hasTimePassed()) {
          letterTicker++;
          _timerUtil.reset();
        }
      } else {
        _alexImage.currentAction = 'default';
        _isAlexMakingMagic = false;
      }
    }

    _renderer.rect(
      x: 0,
      y: 235,
      width: _renderer.getCanvasWidth(),
      height: 30,
      color: Color(
        red: 255,
        green: 255,
        blue: 255,
      ),
    );

    _renderer.print(
      msg: _tokens.toString().substring(0, letterTicker),
      x: 220,
      y: 250,
      font: Font(
        family: 'Arial',
        size: 12,
        color: Color(
          red: 0,
          green: 0,
          blue: 0,
        ),
      ),
    );

    if (_isAlexMakingMagic) {
      _alexImage.render(
        x: 300 + getRandomBetween(-5, 5),
        y: _renderer.getCanvasHeight() - 256 + getRandomBetween(-5, 5),
        width: 128 + getRandomBetween(-5, 5),
        height: 256 + getRandomBetween(-5, 5),
      );
    }

    _alexImage.render(
      x: 300,
      y: _renderer.getCanvasHeight() - 256,
      width: 128,
      height: 256,
    );
  }

  Particle _particleRefresh() {
    {
      return Particle(
        x: getRandomBetween(0, _renderer.getCanvasWidth()),
        y: getRandomBetween(0, _renderer.getCanvasHeight()),
        width: getRandomBetween(1, 5),
        height: getRandomBetween(1, 5),
        alpha: 255,
        lifeSpan: getRandomBetween(100, 200),
        decayRate: getRandomBetween(1, 5),
        velX: getRandomBetween(-2, 2),
        velY: getRandomBetween(-2, 2),
        color: Color(
          red: getRandomBetween(0, 255),
          green: getRandomBetween(0, 255),
          blue: getRandomBetween(0, 255),
        ),
      );
    }
  }

  @override
  // TODO: implement overLayScreens
  Map<String, GameScreenOverlay> get overLayScreens => {};
}
