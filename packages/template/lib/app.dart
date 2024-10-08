import 'package:prompt_magic/screens/main_screen.dart';
import 'package:prompt_magic/screens/screens.dart';
import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/application/teeny_tiny_two_dee.dart';

class TemplateApp extends TeenyTinyTwoDeeApp {
  void init() {
    final Map<String, GameScreen> gameScreens = {};

    gameScreens[Screens.mainScreen.name] = TemplateScreen();

    super.run(gameScreens, Screens.mainScreen.name);
  }
}
