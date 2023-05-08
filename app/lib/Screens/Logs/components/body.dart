import 'package:study_buddy_app/Services/database.dart';
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

  void _loadEventsFromFirebase() async {
    List<Session> sessions = await _getEventsFromFirebase();
    setState(() {
      _sessions = sessions;
    });
  }

  List<Session> _getEventsForDay(DateTime day) {
    List<Session> returnSessions = [];

    for (Session s in _sessions) {
      DateTime sDay =
          DateTime(int.parse(s.year), int.parse(s.month), int.parse(s.day));
      if (isSameDay(sDay, day)) {
        returnSessions.add(s);
      }
      if (sDay.isAfter(day)) break;
    }
    if (returnSessions.isNotEmpty) print(returnSessions[0].day);
    return returnSessions;
  }

  @override
  void initState() {
    super.initState();
    _loadEventsFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Container(
        margin: EdgeInsets.only(top: 70),
        child: FutureBuilder<List<Session>>(
          future: _getEventsFromFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
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
                      color: Colors.transparent,
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
                eventLoader: (day) {
                  return _getEventsForDay(day);
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    print(events);
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
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: events.map((event) {
                            if (event is Session) {
                              // Format the session time and duration
                              final time = '${event.hour}:${event.minute}';
                              final duration = '${event.duration} sec';
                              return Text(
                                '$time - $duration',
                                style: TextStyle(fontSize: 12.0),
                              );
                            } else {
                              return Container();
                            }
                          }).toList(),
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
    );
  }
}
