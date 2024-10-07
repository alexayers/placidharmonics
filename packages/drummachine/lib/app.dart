import 'package:drum_machine/screens/base_screen.dart';
import 'package:drum_machine/screens/screens.dart';
import 'package:teenytinytwodee/application/game_screen.dart';
import 'package:teenytinytwodee/application/teeny_tiny_two_dee.dart';

class DrumMachineApp extends TeenyTinyTwoDeeApp {
  void init() {
    final Map<String, GameScreen> gameScreens = {};

    gameScreens[Screens.baseScreen.name] = BaseScreen();

    super.run(gameScreens, Screens.baseScreen.name);
  }
}
