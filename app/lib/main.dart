import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:study_buddy_app/Screens/Welcome/welcome_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:study_buddy_app/Services/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

class MyApp extends StatelessWidget {
  static int xpAmount = 0;
  static int coinsAmount = 0;
  static int level = 0;
  static bool music = false;
  static bool doNotDisturb = false;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Study Buddy",
      theme: ThemeData(
        primaryColor: Colors.yellow,
      ),
      home: WelcomeScreen(),
    );
  }

}