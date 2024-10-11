import 'package:glitch/screens/main_screen.dart';
import 'package:glitch/screens/screens.dart';
import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/application/teeny_tiny_two_dee.dart';

class GlitchApp extends TeenyTinyTwoDeeApp {
  void init() {
    final Map<String, GameScreen> gameScreens = {};

    gameScreens[Screens.mainScreen.name] = GlitchScreen();

    super.run(gameScreens, Screens.mainScreen.name);
  }
}
