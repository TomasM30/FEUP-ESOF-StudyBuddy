import 'package:flutter/material.dart';
import 'package:study_buddy_app/Screens/BuddyScreen/components/background.dart';
import 'package:study_buddy_app/Screens/timer_screen.dart';
import 'package:study_buddy_app/components/toogle_button_menu.dart';

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MenuButton(
              press2: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Clock();
                    },
                  ),
                );
              },
              iconSrc1: 'assets/icons/settings.svg',
              iconSrc2: 'assets/icons/studymode.svg',
              iconSrc3: 'assets/icons/shop.svg',
            ),
          ),
        ],
      ),
    ));
  }
}
