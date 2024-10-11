import 'package:teenytinytwodee/application/game_screen_overlay.dart';
import 'package:teenytinytwodee/input/mouse.dart';

abstract class GameScreen {
  void init();

  void onEnter();

  void onExit();

  void logicLoop();

  void renderLoop();

  Map<String, GameScreenOverlay> get overLayScreens;

  void keyboard(int keyCode);

  void mouseClick(int x, int y, MouseButton mouseButton);

  void mouseMove(int x, int y);
}
