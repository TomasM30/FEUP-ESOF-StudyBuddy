import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
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
  bool isRunning = false;
  bool doNotDisturb = false;
  bool music = false;
  DateTime timeNow = DateTime.now();

  Future<void> checkDndPermisions() async{
    bool? isGranted = await FlutterDnd.isNotificationPolicyAccessGranted;
    if (isGranted != null && !isGranted){
      showNotificationBubble();
      FlutterDnd.gotoPolicySettings();
    }
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin(); 

  void showNotificationBubble() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    
    await flutterLocalNotificationsPlugin.show(
      0,
      'Turn on DND access',
      'Please turn on DND access for this app in your system settings',
      platformChannelSpecifics,
    );
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
                        doNotDisturb = !doNotDisturb;
                        int filter = doNotDisturb ? FlutterDnd.INTERRUPTION_FILTER_ALARMS : FlutterDnd.INTERRUPTION_FILTER_ALL;
                        FlutterDnd.setInterruptionFilter(filter);
                      },
                      backgroundColor: Color(0xffcd9d57),
                      child: Transform.scale(
                        scale: 1.6,
                        child: Icon(doNotDisturb
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
                        music = !music;
                      },
                      backgroundColor: Color(0xffcd9d57),
                      child: Transform.scale(
                        scale: 1.7,
                        child:
                            Icon(!music ? Icons.music_note : Icons.music_off),
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
