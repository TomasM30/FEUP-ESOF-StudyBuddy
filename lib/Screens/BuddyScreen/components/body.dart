import 'package:flutter/material.dart';
import 'package:study_buddy_app/Screens/BuddyScreen/components/background.dart';
import 'package:study_buddy_app/Screens/timer_screen.dart';

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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "STUDY BUDDY",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: FloatingActionButton(
              heroTag: "FAB1",
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Clock()));
              },
              backgroundColor: Color(0xffcd9d57),
              child: Transform.scale(
                scale: 1.7,
                child: Icon(Icons.school),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
