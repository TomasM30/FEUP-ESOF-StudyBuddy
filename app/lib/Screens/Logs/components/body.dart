import 'package:study_buddy_app/Screens/BuddyScreen/main_screen.dart';
import 'package:study_buddy_app/Services/database.dart';
import 'package:study_buddy_app/components/custom_button_color.dart';
import 'package:study_buddy_app/components/sessions.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

import 'background.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  List<Session> _sessions = [];

  Future<List<Session>> _getEventsFromFirebase() async {
    DatabaseService databaseService = DatabaseService();
    List<Session> sessions = await databaseService.loadSessions();
    return sessions;
  }

  String normalizeDuration(String duration) {
    int durationInt = int.parse(duration);
    int durationHours = durationInt ~/ 3600;
    int durationMinutes = (durationInt % 3600) ~/ 60;
    int durationSeconds = durationInt % 60;

    if (durationInt < 60) {
      if (durationSeconds == 1) {
        return '1 second';
      } else {
        return '$durationSeconds seconds';
      }
    } else if (durationInt < 3600) {
      String minutesString =
          durationMinutes == 1 ? '1 minute' : '$durationMinutes minutes';
      String secondsString =
          durationSeconds == 1 ? '1 second' : '$durationSeconds seconds';
      return '$minutesString and $secondsString';
    } else {
      String hoursString =
          durationHours == 1 ? '1 hour' : '$durationHours hours';
      String minutesString =
          durationMinutes == 1 ? '1 minute' : '$durationMinutes minutes';
      return '$hoursString and $minutesString';
    }
  }

  String getStartHour(
      String endHour, String endMin, String endSec, String duration) {
    int endHourInt = int.parse(endHour);
    int endMinInt = int.parse(endMin);
    int endSecInt = int.parse(endSec);
    int durationInt = int.parse(duration);

    int totalEndTimeInSeconds = endHourInt * 3600 + endMinInt * 60 + endSecInt;
    int totalStartTimeInSeconds = totalEndTimeInSeconds - durationInt;

    int startHour = totalStartTimeInSeconds ~/ 3600;
    int startMin = (totalStartTimeInSeconds % 3600) ~/ 60;
    int startSec = totalStartTimeInSeconds % 60;

    return '${startHour.toString().padLeft(2, '0')}:${startMin.toString().padLeft(2, '0')}:${startSec.toString().padLeft(2, '0')}';
  }

  String getEndHour(String endHour, String endMin, String endSec) {
    return '${endHour.padLeft(2, '0')}:${endMin.padLeft(2, '0')}:${endSec.padLeft(2, '0')}';
  }

  String getSessionN(String year, String month, String day, String endHour,
      String endMin, String endSec, String duration) {
    for (int i = 0; i < _sessions.length; i++) {
      if (_sessions[i].year == year &&
          _sessions[i].month == month &&
          _sessions[i].day == day &&
          _sessions[i].hour == endHour &&
          _sessions[i].minute == endMin &&
          _sessions[i].seconds == endSec &&
          _sessions[i].duration == duration) {
        return (i + 1).toString();
      }
    }
    return '';
  }

  void _loadEventsFromFirebase() async {
    List<Session> sessions = await _getEventsFromFirebase();
    setState(() {
      _sessions = sessions;
    });
  }

  Future<List<Session>> _getEventsForDay(DateTime day) async {
    List<Session> returnSessions = [];

    for (Session s in _sessions) {
      DateTime sDay =
          DateTime(int.parse(s.year), int.parse(s.month), int.parse(s.day));
      if (isSameDay(sDay, day)) {
        returnSessions.add(s);
      }
      if (sDay.isAfter(day)) break;
    }
    return returnSessions;
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadEventsFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Background(
        child: Stack(children: [
      Container(
        margin: EdgeInsets.only(top: 70),
        child: FutureBuilder<List<Session>>(
          future: _getEventsFromFirebase(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error loading events'),
              );
            } else {
              _sessions = snapshot.data ?? [];
              return TableCalendar(
                firstDay: DateTime.utc(2023, 4, 1),
                lastDay: DateTime.now().add(Duration(days: 365)),
                focusedDay: _focusedDay,
                daysOfWeekVisible: false,
                locale: 'en_US',
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: 'Wishes',
                  ),
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                ),
                calendarStyle: CalendarStyle(
                  canMarkersOverflow: true,
                  defaultTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Wishes',
                  ),
                  weekendTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Wishes',
                  ),
                  holidayTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Wishes',
                  ),
                  outsideTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Wishes',
                  ),
                  selectedTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Wishes',
                  ),
                  todayTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Wishes',
                  ),
                  outsideDaysVisible: false,
                  weekendDecoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  holidayDecoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Color(0xff251b00),
                      width: 2,
                    ),
                  ),
                ),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    return Container(
                      margin: EdgeInsets.all(4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.transparent,
                          width: 2,
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: screenHeight * 0.5),
        child: FutureBuilder<List<Session>>(
          future: _getEventsForDay(_selectedDay),
          builder:
              (BuildContext context, AsyncSnapshot<List<Session>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              final sessions = snapshot.data;
              return ListView.builder(
                itemCount: sessions?.length,
                itemBuilder: (BuildContext context, int index) {
                  final day = sessions![index];
                  return SizedBox(
                    height: screenHeight * 0.1,
                    child: ListTile(
                      title: Text(
                        "Session " + (index+1).toString(),
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: "Arial",
                        ),
                      ),
                      subtitle: Text(
                        normalizeDuration(day.duration),
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff251b00),
                          fontFamily: "Arial",
                        ),
                      ),
                      trailing: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Start: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0xe7ffffff),
                                fontFamily: "Arial",
                              ),
                            ),
                            TextSpan(
                              text: getStartHour(day.hour, day.minute,
                                  day.seconds, day.duration),
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff251b00),
                                fontFamily: "Arial",
                              ),
                            ),
                            TextSpan(
                              text: "\n  End: ",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xe7ffffff),
                                fontWeight: FontWeight.bold,
                                fontFamily: "Arial",
                              ),
                            ),
                            TextSpan(
                              text:
                                  getEndHour(day.hour, day.minute, day.seconds),
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff251b00),
                                fontFamily: "Arial",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
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
    ]));
  }
}
