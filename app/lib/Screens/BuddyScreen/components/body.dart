import 'dart:math';

import 'package:flutter/material.dart';
import 'package:study_buddy_app/Screens/BuddyScreen/components/BuddyGame.dart';
import 'package:study_buddy_app/Screens/SettingsScreen/settings_screen.dart';
import 'package:study_buddy_app/Screens/Timer/timer_screen.dart';
import 'package:study_buddy_app/Services/database.dart';
import 'package:study_buddy_app/Services/user_setting.dart';
import 'package:study_buddy_app/components/custom_button.dart';
import 'package:study_buddy_app/components/level_up_bar.dart';
import 'package:study_buddy_app/components/toogle_button_menu_vertical.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.game}) : super(key: key);

  final BuddyGame game;

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  double lft = 40;
  double aux = 0.11;
  bool showXp = false;
  DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    var quatro = widget.game.quatro;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (UserSettings.level == 1) {
      lft = 45;
    } else if (UserSettings.level == 20) {
      lft = 32;
    }
    for (int i = 0; i < UserSettings.xpAmount.toString().length; i++) {
      if (UserSettings.xpAmount == 1) {
        break;
      }
      aux = aux - 0.013;
    }
    return Stack(
        key: Key("buddyScreen"),
        children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomButtons(
              width: 70,
              iconSrc: 'assets/icons/money.svg',
            ),
            Text(
              "\$${UserSettings.coinsAmount}",
              style: TextStyle(
                  fontSize: 40, color: Colors.white, fontFamily: "Wishes"),
            ),
          ]),
        ),
        Visibility(
          visible: showXp,
          child: Positioned(
            top: height * 0.08,
            left: width * 0.08,
            child: LevelUpBar(
              currentLevel: UserSettings.level,
              currentXp: UserSettings.xpAmount,
              nextLevelXp: _databaseService.getNextLvlXp(UserSettings.level),
            ),
          ),
        ),
        Visibility(
          visible: showXp,
          child: Positioned(
            top: height * 0.165,
            left: width * aux,
            child: Transform.rotate(
              angle: pi / 2,
              child: Text(
                "${UserSettings.xpAmount}",
                style: TextStyle(
                    fontSize: 40,
                    color: Color(0xffffffff),
                    fontFamily: "Wishes"),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 10.5),
          child: CustomButtons(
            width: 90,
            iconSrc: 'assets/icons/newLevelStar.svg',
            press: () {
              aux = 0.11;
              setState(() {
                showXp = !showXp;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 32, left: lft),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "${UserSettings.level}",
              style: TextStyle(
                  fontSize: 50, color: Colors.white, fontFamily: "Wishes"),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 15, right: 8),
            child: MenuButtonV(
              press2: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TimerScreen();
                    },
                  ),
                );
              },
              press4: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SettingsScreen();
                    },
                  ),
                );
              },
              width: 70,
              iconSrc1: 'assets/icons/settings.svg',
              iconSrc2: 'assets/icons/studymode.svg',
              iconSrc3: 'assets/icons/shop.svg',
              iconSrc4: 'assets/icons/newSettings.svg',
            ),
          ),
        ),
      ],
    );
  }
}
