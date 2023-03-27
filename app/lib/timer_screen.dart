import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'main_screen.dart';


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
    Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {
          timeNow = DateTime.now();
        });
      },
    ); 
    setAudio();  
  }

  // Create a reference to a file from a Google Cloud Storage URI
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
                      onPressed: () {
                        doNotDisturb = !doNotDisturb;
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
                        setAudio();
                        
                      },
                      backgroundColor: Color(0xffcd9d57),
                      child: Transform.scale(
                        scale: 1.7,
                        child:
                            Icon(music ? Icons.music_note : Icons.music_off),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                      heroTag: "FAB5",
                      onPressed: () {
                        audioPlayer.pause();
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


