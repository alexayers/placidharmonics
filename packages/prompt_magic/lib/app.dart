import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/application/teeny_tiny_two_dee.dart';
import 'package:test_bed/screens/main_screen.dart';
import 'package:test_bed/screens/screens.dart';

class PlacidHarmonics extends TeenyTinyTwoDeeApp {
  void init() {
    final Map<String, GameScreen> gameScreens = {};

    gameScreens[Screens.mainScreen.name] = MainScreen();

    super.run(gameScreens, Screens.mainScreen.name);
  }
}
