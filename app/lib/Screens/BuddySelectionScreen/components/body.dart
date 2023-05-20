import 'package:flutter/material.dart';
import 'package:study_buddy_app/Screens/BuddyScreen/components/BuddyGame.dart';
import 'package:study_buddy_app/Screens/BuddyScreen/main_screen.dart';
import 'package:study_buddy_app/Screens/Logs/components/background.dart';
import 'package:study_buddy_app/Services/database.dart';
import 'package:study_buddy_app/Services/user_setting.dart';
import 'package:study_buddy_app/components/buddy.dart';
import 'package:study_buddy_app/components/custom_button.dart';
import 'package:study_buddy_app/components/custom_button_color.dart';


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    List<Buddy> buddies = BuddyGame().getBuddies();

    return Stack(
      children: [
        Background(
          child: Container(
            margin: EdgeInsets.only(top: screenHeight * 0.26),
            child: GridView.count(
            // crossAxisCount is the number of columns
              crossAxisCount: 2,
              
              // This creates two columns with two items in each column
              children: List.generate(buddies.length, (index) {
                return Center(
                  child: IconButton(
                      icon: Image.asset("assets/images/${buddies[index].image}"),
                      iconSize: 200,
                      onPressed: () {
                        databaseService.updateBuddy(index);
                        UserSettings.buddy = index;
                        if (!mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MainScreen();
                            },
                          ),
                        );
                      },
                    ),
                  );
              },
            )
          )
          
        ),
        ),
        Positioned(
            top: screenHeight * 0.01,
            left: screenWidth * 0.03,
            child: CustomButtonsColor(
              iconSrc: "assets/icons/go-back-simple.svg",
              press: () {
                if (!mounted) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MainScreen();
                    },
                  ),
                );
              },
              color: Color(0xd0f3edd7),
            ),
          ),
      ],
    );
  }
}