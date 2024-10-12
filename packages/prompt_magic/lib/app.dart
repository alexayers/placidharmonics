import 'package:prompt_magic/screens/main_screen.dart';
import 'package:prompt_magic/screens/screens.dart';
import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/application/teeny_tiny_two_dee.dart';

class PlacidHarmonics extends TeenyTinyTwoDeeApp {
  PlacidHarmonics({required super.application});

  void init() {
    final Map<String, GameScreen> gameScreens = {};

    gameScreens[Screens.mainScreen.name] = MainScreen();

    super.run(gameScreens, Screens.mainScreen.name);
  }
}
