import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'main_screen.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _Clock();
}

class _Clock extends State<Clock> {
  Duration duration = Duration();
  Timer? timer;
  DateTime timeNow = DateTime.now();
  bool isRunning = false;

  Future<void> checkDndPermisions() async{
    bool? isGranted = await FlutterDnd.isNotificationPolicyAccessGranted;
    if (isGranted != null && !isGranted){
      showDndDialog();
    }
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {
          timeNow = DateTime.now();
        });
      },
    );
  }

  Future<void> showDndDialog() async{
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("Heads Up!"),
          content: const Text("To enable the Do-Not-Disturb mode through the app, you will have to allow the respective permissions in the settings menu"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                FlutterDnd.gotoPolicySettings();
              },
              child: const Text("Go to Settings")) 
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xffDFAD47),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: FloatingActionButton(
                        heroTag: "FAB2",
                        onPressed: () {
                          setState(() {
                            isRunning = !isRunning;
                            if (isRunning) {
                              startTimer();
                            } else {
                              stopTimer();
                            }
                          });
                        },
                        backgroundColor: Color(0xffcd9d57),
                        child: Transform.scale(
                          scale: 1.7,
                          child: Icon(
                              !isRunning ? Icons.timer_outlined : Icons.stop),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                      heroTag: "FAB3",
                      onPressed: () async{
                        await checkDndPermisions();
                        MyApp.doNotDisturb = !MyApp.doNotDisturb;
                        int filter = MyApp.doNotDisturb ? FlutterDnd.INTERRUPTION_FILTER_ALARMS : FlutterDnd.INTERRUPTION_FILTER_ALL;
                        FlutterDnd.setInterruptionFilter(filter);
                      },
                      backgroundColor: Color(0xffcd9d57),
                      child: Transform.scale(
                        scale: 1.6,
                        child: Icon(!MyApp.doNotDisturb
                            ? Icons.notifications
                            : Icons.notifications_off),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                      heroTag: "FAB4",
                      onPressed: () {
                        MyApp.music = !MyApp.music;
                      },
                      backgroundColor: Color(0xffcd9d57),
                      child: Transform.scale(
                        scale: 1.7,
                        child:
                            Icon(!MyApp.music ? Icons.music_note : Icons.music_off),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                      heroTag: "FAB5",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen()));
                      },
                      backgroundColor: Color(0xffcd9d57),
                      child: Transform.scale(
                        scale: 1.7,
                        child: Icon(Icons.undo),
                      ),
                    ),
                  ],
                ),
              ),
              buildTime(),
              Text(
                DateFormat('hh:mm a').format(timeNow),
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
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
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
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
      style: TextStyle(fontSize: 65, color: Colors.white),
    );
  }
}
