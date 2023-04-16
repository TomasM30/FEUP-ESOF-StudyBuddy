import 'package:flutter/material.dart';
import 'package:study_buddy_app/Services/database.dart';

import 'components/body.dart';

class MainScreen extends StatelessWidget {
  final DatabaseService _databaseService = DatabaseService();
  static int xpAmount = 0;

  @override
  Widget build(BuildContext context) {
    _databaseService.getXp().then((value) {
      xpAmount = value!;
    });
    return Scaffold(
      body: Body(),
    );
  }
}
