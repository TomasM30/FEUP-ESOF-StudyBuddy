import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy_app/Screens/BuddyScreen/components/BuddyGame.dart';

import 'components/body.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key, this.hasGame = true}) : super(key: key);

  final bool hasGame;


  @override
  Widget build(BuildContext context) {
    BuddyGame? game;
    if (hasGame) {
      game = BuddyGame();
    }

    return Scaffold(
      body: Stack(
        children: [
          if (hasGame) GameWidget(game: game!),
          Body(game: game),
        ],
      ),
    );
  }
}