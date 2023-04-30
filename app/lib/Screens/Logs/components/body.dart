import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

import 'background.dart';

class Body extends StatefulWidget{
  const Body({Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Background(
      child: TableCalendar(
        firstDay: DateTime.utc(2023, 4, 1),
        lastDay: DateTime.now().add(Duration(days: 365)),
        focusedDay: _focusedDay,
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
            borderRadius: BorderRadius.circular(10),
          ),
          todayDecoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),        

        selectedDayPredicate: (day){
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay){
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });

        },
        
      ),
    );
  }
}


