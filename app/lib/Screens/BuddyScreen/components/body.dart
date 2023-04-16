import 'package:flutter/material.dart';
import 'package:study_buddy_app/Screens/SettingsScreen/settings_screen.dart';
import 'package:study_buddy_app/Screens/Timer/timer_screen.dart';
import 'package:study_buddy_app/components/custom_button.dart';
import 'package:study_buddy_app/components/toogle_button_menu_vertical.dart';
import 'package:study_buddy_app/main.dart';


import 'background.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  int xpAmount = MyApp.xpAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomButtons(
                  width: 70,
                  iconSrc: 'assets/icons/money.svg',
                ),
                Text(
                    "\$${MyApp.coinsAmount}",
                    style: TextStyle(
                      fontSize: 40, color: Colors.white, fontFamily: "Wishes"),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 8),
              child: CustomButtons(
                width: 85,
                iconSrc: 'assets/icons/newLevelStar.svg',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32, left: 35),
              child: Align(
                alignment: Alignment.topLeft,
                  child: Text(
                    xpAmount.toString(),
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
        ),
      ),
    );
  }
}
