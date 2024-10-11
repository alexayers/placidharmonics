import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/application/teeny_tiny_two_dee.dart';
import 'package:template/screens/main_screen.dart';
import 'package:template/screens/screens.dart';

class TemplateApp extends TeenyTinyTwoDeeApp {
  void init() {
    final Map<String, GameScreen> gameScreens = {};

    gameScreens[Screens.mainScreen.name] = TemplateScreen();

    super.run(gameScreens, Screens.mainScreen.name);
  }
}
