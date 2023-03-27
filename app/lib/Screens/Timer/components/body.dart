import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:study_buddy_app/Screens/BuddyScreen/main_screen.dart';
import 'package:study_buddy_app/components/toogle_button_menu_horizontal.dart';

import 'background.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  Duration duration = Duration();
  Timer? timer;
  bool doNotDisturb = false;
  bool music = false;
  DateTime timeNow = DateTime.now();
  final audioPlayer = AudioPlayer();


  Future setAudio() async{
    const url = "https://firebasestorage.googleapis.com/v0/b/study-buddy-6443c.appspot.com/o/music%2Fstudy1.mp3?alt=media&token=c31e03f3-0820-4bd8-befc-b0762b9554f2";
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);

    if (music == true){
      audioPlayer.play(url, isLocal: false);
    }
    else{
      audioPlayer.pause();
    }
  }

  @override
  void initState() {
    super.initState();
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
                      audioPlayer.pause();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MainScreen();
                          },
                        ),
                      );
                    },
                    press2: () {
                      setState(() {
                        doNotDisturb = !doNotDisturb;
                      });
                    },
                    press3: () {
                      setState(() {
                        music = !music;
                        setAudio();
                      });
                    },
                    iconSrc1: 'assets/icons/settings.svg',
                    iconSrc3: music ? 'assets/icons/soundon.svg' : 'assets/icons/soundoff.svg',
                    iconSrc4: 'assets/icons/exit.svg',
                    iconSrc2: !doNotDisturb ? 'assets/icons/notifoff.svg' : 'assets/icons/notifon.svg',
                    width: 70,
                  ),
                ),
              ),

              Align(
                  alignment: Alignment.center,
                  child: buildTime()),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    DateFormat('hh:mm a').format(timeNow),
                    style: TextStyle(
                        fontSize: 50, color: Colors.white, fontFamily: "Wishes"),
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
