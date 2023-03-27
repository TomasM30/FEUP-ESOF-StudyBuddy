import 'package:flutter/material.dart';
import 'package:study_buddy_app/Screens/BuddyScreen/components/background.dart';
import 'package:study_buddy_app/Screens/Timer/timer_screen.dart';
import 'package:study_buddy_app/components/custom_button.dart';
import 'package:study_buddy_app/components/toogle_button_menu_vertical.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Background(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomButtons(
                  width: 70,
                  iconSrc: 'assets/icons/money.svg',
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
                  width: 70,
                  iconSrc1: 'assets/icons/settings.svg',
                  iconSrc2: 'assets/icons/studymode.svg',
                  iconSrc3: 'assets/icons/shop.svg',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
