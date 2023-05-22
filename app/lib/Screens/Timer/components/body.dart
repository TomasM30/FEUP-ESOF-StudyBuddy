import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:study_buddy_app/Services/database.dart';
import 'package:study_buddy_app/Screens/BuddyScreen/main_screen.dart';
import 'package:study_buddy_app/Services/user_setting.dart';
import 'package:study_buddy_app/components/toogle_button_menu_horizontal.dart';

import 'background.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  bool min = false;
  bool clicked = false;
  int xpAmount = UserSettings.xpAmount;
  int coinsAmount = UserSettings.coinsAmount;
  final DatabaseService _databaseService = DatabaseService();
  Duration duration = Duration();
  Timer? timer;
  DateTime timeNow = DateTime.now();
  final audioPlayer = AudioPlayer();
  bool isFirstHour = true;
  double multiplier = UserSettings.multiplier;

  Future setAudio() async {
    const url =
        "https://firebasestorage.googleapis.com/v0/b/study-buddy-6443c.appspot.com/o/music%2Fstudy1.mp3?alt=media&token=c31e03f3-0820-4bd8-befc-b0762b9554f2";
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);

    if (UserSettings.music == true) {
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
        key: Key("studyModeScreen"),
        body: Background(
          child: Stack(
            children: [
              Visibility(
                visible: UserSettings.streak > 1 && !clicked,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children:[
                        SvgPicture.asset(
                          "assets/images/streak1.svg",
                          width: 100,
                        ),
                      ]
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 8),
                  child: MenuButtonH(
                    press: () {
                      setState(() {
                        clicked = !clicked;
                      });
                    },
                    press4: () async {
                      _databaseService.setLastSession();
                      UserSettings.sessions =
                          await _databaseService.loadSessions();
                      Future.delayed(Duration(seconds: 2));
                      _databaseService
                          .updateCoins((coinsAmount * multiplier).round());
                      _databaseService
                          .updateXp((xpAmount * multiplier).round());
                      UserSettings.xpAmount = xpAmount;
                      UserSettings.coinsAmount = coinsAmount;
                      int lvl = await _databaseService
                          .getLvl((await _databaseService.getXp())!);
                      _databaseService.updateLevel(lvl);
                      UserSettings.level = lvl;
                      audioPlayer.pause();
                      UserSettings.music = false;

                      if (!mounted) return;
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
                        UserSettings.doNotDisturb = !UserSettings.doNotDisturb;
                        int filter = UserSettings.doNotDisturb
                            ? FlutterDnd.INTERRUPTION_FILTER_ALARMS
                            : FlutterDnd.INTERRUPTION_FILTER_ALL;
                        FlutterDnd.setInterruptionFilter(filter);
                      });
                    },
                    press3: () {
                      setState(() {
                        UserSettings.music = !UserSettings.music;
                        setAudio();
                      });
                    },
                    iconSrc1: 'assets/icons/settings.svg',
                    iconSrc3: UserSettings.music
                        ? 'assets/icons/soundon.svg'
                        : 'assets/icons/soundoff.svg',
                    iconSrc4: 'assets/icons/exit.svg',
                    iconSrc2: UserSettings.doNotDisturb
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
                    key: Key("timerText"),
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
        min = true;
        xpAmount++;
        coinsAmount += 4;
      } else if (!isFirstHour) {
        xpAmount = xpAmount + 2;
        coinsAmount += 4;
      }
      UserSettings.duration = duration.inSeconds;
      if (min){
        _databaseService.updateCoins((multiplier * coinsAmount).round());
        _databaseService.updateXp((multiplier * xpAmount).round());
      } else {
        _databaseService.updateCoins((coinsAmount).round());
        _databaseService.updateXp((xpAmount).round());
      }

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
