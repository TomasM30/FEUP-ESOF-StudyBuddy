import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'timer_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Color(0xff9ABA8F),
      body: Column(
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Clock())
                );
              },
              backgroundColor: Color(0xffcd9d57),
              child: Transform.scale(
                scale: 1.7,
                child: Icon(Icons.school),
              ),
            ),
          ),
        ],
      )
  );
}


