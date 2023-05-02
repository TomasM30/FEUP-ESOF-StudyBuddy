import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy_app/Screens/BuddyScreen/components/BuddyGame.dart';

import 'components/body.dart';

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var game = BuddyGame();
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: game),
          Body(game: game),
        ],
      ),
    );
  }
}