import 'package:flutter/material.dart';
import 'package:study_buddy_app/Screens/BuddyScreen/components/BuddyGame.dart';
import 'package:study_buddy_app/Screens/BuddyScreen/components/background.dart';
import 'package:study_buddy_app/Screens/Logs/log_screen.dart';
import 'package:study_buddy_app/Screens/SettingsScreen/settings_screen.dart';
import 'package:study_buddy_app/Screens/Shop/shop_screen.dart';
import 'package:study_buddy_app/Screens/Timer/timer_screen.dart';
import 'package:study_buddy_app/Services/database.dart';
import 'package:study_buddy_app/Services/user_setting.dart';
import 'package:study_buddy_app/components/custom_button.dart';
import 'package:study_buddy_app/components/level_up_bar.dart';
import 'package:study_buddy_app/components/toogle_button_menu_vertical.dart';

import '../../BuddySelectionScreen/species_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key, this.game}) : super(key: key);

  final BuddyGame? game;


  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  double lft = 40;
  double tAux = 0.08;
  bool showXp = false;
  DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (UserSettings.level == 1) {
      lft = 45;
    } else if (UserSettings.level == 20) {
      lft = 32;
    }
    return Stack(
      key: Key("buddyScreen"),
      children: [
        if (widget.game == null)
          Background(child: Text("")),
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
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 32, left: lft),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "",
                  style: TextStyle(
                      fontSize: 50, color: Colors.white, fontFamily: "Wishes"),
                ),
              ),
            ),
            Visibility(
              visible: showXp,
              child: Row(
                children: [
                  Transform.translate(
                    offset: Offset(width * 0.073, -height * 0.0075),
                    child: LevelUpBar(
                      currentLevel: UserSettings.level,
                      currentXp: UserSettings.xpAmount,
                      nextLevelXp:
                          _databaseService.getNextLvlXp(UserSettings.level),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(width * 0.02, 0),
                    child: Column(
                      children: UserSettings.xpAmount
                          .toString()
                          .split('')
                          .map((char) => Text(
                                char,
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Color(0xffffffff),
                                  fontFamily: "Wishes",
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 10.5),
          child: CustomButtons(
            width: 90,
            iconSrc: 'assets/icons/newLevelStar.svg',
            press: () {
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
              press2: () async {
                if(UserSettings.level != 0){
                _databaseService.streakBuild();
                Future.delayed(Duration(seconds: 1));
                UserSettings.streak = (await _databaseService.getStreak())!;}
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TimerScreen();
                    },
                  ),
                );
              },
              press3: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ShopScreen();
                    },
                  ),
                );
              },
              press4: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LogScreen();
                    },
                  ),
                );
              },
              press5: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SettingsScreen();
                    },
                  ),
                );
              },
              press6: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BuddySelectionScreen();
                    },
                  ),
                );
              },
              width: 70,
              iconSrc1: 'assets/icons/settings.svg',
              iconSrc2: 'assets/icons/studymode.svg',
              iconSrc3: 'assets/icons/shop.svg',
              iconSrc4: 'assets/icons/log.svg',
              iconSrc5: 'assets/icons/newSettings.svg',
              iconSrc6: 'assets/icons/EggIcon.svg',
            ),
          ),
        ),
      ],
    );
  }

}
