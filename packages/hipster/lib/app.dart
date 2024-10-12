import 'package:hipster/screens/results_screen.dart';
import 'package:hipster/screens/screens.dart';
import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/application/teeny_tiny_two_dee.dart';

class HipsterApp extends TeenyTinyTwoDeeApp {
  HipsterApp({required super.application});

  void init() {
    final Map<String, GameScreen> gameScreens = {};

    gameScreens[Screens.mainScreen.name] = HipsterScreen();

    super.run(gameScreens, Screens.mainScreen.name);
  }
}
