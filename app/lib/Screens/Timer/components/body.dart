import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:study_buddy_app/Services/database.dart';
import 'package:study_buddy_app/Screens/BuddyScreen/main_screen.dart';
import 'package:study_buddy_app/components/toogle_button_menu_horizontal.dart';
import 'package:study_buddy_app/main.dart';

import 'background.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  int xpAmount = MyApp.xpAmount;
  final DatabaseService _databaseService = DatabaseService();
  Duration duration = Duration();
  Timer? timer;
  DateTime timeNow = DateTime.now();
  final audioPlayer = AudioPlayer();
  bool isFirstHour = true;

  Future setAudio() async {
    const url =
        "https://firebasestorage.googleapis.com/v0/b/study-buddy-6443c.appspot.com/o/music%2Fstudy1.mp3?alt=media&token=c31e03f3-0820-4bd8-befc-b0762b9554f2";
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);

    if (MyApp.music == true) {
      audioPlayer.play(url, isLocal: false);
    } else {
      audioPlayer.pause();
    }
  }

  Future<void> checkDndPermisions() async {
    bool? isGranted = await FlutterDnd.isNotificationPolicyAccessGranted;
    if (isGranted != null && !isGranted) {
      showDndDialog();
    }
  }

  Future<void> showDndDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Heads Up!"),
            content: const Text(
                "To enable the Do-Not-Disturb mode through the app, you will have to allow the respective permissions in the settings menu"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    FlutterDnd.gotoPolicySettings();
                  },
                  child: const Text("Go to Settings"))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    isFirstHour = true;
    startTimer();
    Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (mounted) {
          setState(() {
            timeNow = DateTime.now();
          });
        }
      },
    );
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Background(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 8),
                  child: MenuButtonH(
                    press4: () {
                      _databaseService.updateXp(xpAmount);
                      MyApp.xpAmount = xpAmount;
                      audioPlayer.pause();
                      MyApp.music = false;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            super.widget;
                            return MainScreen();
                          },
                        ),
                      );
                    },
                    press2: () async {
                      await checkDndPermisions();
                      setState(() {
                        MyApp.doNotDisturb = !MyApp.doNotDisturb;
                        int filter = MyApp.doNotDisturb
                            ? FlutterDnd.INTERRUPTION_FILTER_ALARMS
                            : FlutterDnd.INTERRUPTION_FILTER_ALL;
                        FlutterDnd.setInterruptionFilter(filter);
                      });
                    },
                    press3: () {
                      setState(() {
                        MyApp.music = !MyApp.music;
                        setAudio();
                      });
                    },
                    iconSrc1: 'assets/icons/settings.svg',
                    iconSrc3: MyApp.music
                        ? 'assets/icons/soundon.svg'
                        : 'assets/icons/soundoff.svg',
                    iconSrc4: 'assets/icons/exit.svg',
                    iconSrc2: MyApp.doNotDisturb
                        ? 'assets/icons/notifoff.svg'
                        : 'assets/icons/notifon.svg',
                    width: 70,
                  ),
                ),
              ),
              Align(alignment: Alignment.center, child: buildTime()),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    DateFormat('hh:mm a').format(timeNow),
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontFamily: "Wishes"),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  addTime() {
    const addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      if (duration.inHours == 1 &&
          duration.inMinutes == 0 &&
          duration.inSeconds % 60 == 0) {
        isFirstHour = false;
      } else if ((isFirstHour &&
              duration.inMinutes != 0 &&
              duration.inMinutes % 2 == 0 &&
              duration.inSeconds % 60 == 0 &&
              duration.inSeconds != 0) ||
          (isFirstHour &&
              duration.inMinutes == 0 &&
              duration.inSeconds % 60 == 0 &&
              duration.inSeconds != 0)) {
        xpAmount++;
      } else if (!isFirstHour) {
        xpAmount = xpAmount + 2;
      }
      _databaseService.updateXp(xpAmount);
      duration = Duration(seconds: seconds);
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        addTime();
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours.remainder(60));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Text(
      '$hours\u0068:$minutes\u0027:$seconds\u0027\u0027',
      style: TextStyle(fontSize: 90, color: Colors.white, fontFamily: "Wishes"),
    );
  }

}
