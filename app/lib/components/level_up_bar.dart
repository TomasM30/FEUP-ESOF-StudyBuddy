import 'dart:math';

import 'package:flutter/material.dart';

class LevelUpBar extends StatelessWidget {
  final int currentXp;
  final int nextLevelXp;
  final int currentLevel;

  LevelUpBar({
    required this.currentLevel,
    required this.currentXp,
    required this.nextLevelXp,
  });

  @override
  Widget build(BuildContext context) {
    double progress = currentXp / nextLevelXp;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 6),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.085,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Color(0xd0f3edd7),
                width: 2.0,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Stack(
                children: [
                  Container(
                    color: Colors.transparent,
                  ),
                  FractionallySizedBox(
                    heightFactor: progress,
                    child: Container(
                      color: Color(0xc8ead3a5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
