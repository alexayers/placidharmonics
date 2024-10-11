import 'package:teenytinytwodee/teenytinytwodee.dart';

import 'package:vocaloid/screens/screens.dart';
import 'package:vocaloid/screens/vocaloid_screen.dart';

class VocaloidApp extends TeenyTinyTwoDeeApp {
  void init() {
    final Map<String, GameScreen> gameScreens = {};

    gameScreens[Screens.mainScreen.name] = VocaloidScreen();

    super.run(gameScreens, Screens.mainScreen.name);
  }
}
