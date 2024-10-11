import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/application/game_screen_overlay.dart';
import 'package:teenytinytwodee/input/mouse.dart';

class TemplateScreen implements GameScreen {
  @override
  void init() {}

  @override
  void keyboard(int keyCode) {}

  @override
  void logicLoop() {}

  @override
  void mouseClick(int x, int y, MouseButton mouseButton) {}

  @override
  void mouseMove(int x, int y) {}

  @override
  void onEnter() {}

  @override
  void onExit() {}

  @override
  void renderLoop() {}

  @override
  // TODO: implement overLayScreens
  Map<String, GameScreenOverlay> get overLayScreens => {};
}
