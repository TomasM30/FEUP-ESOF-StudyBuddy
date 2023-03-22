import 'package:flutter/material.dart';
import '../../../components/email_box.dart';
import '../../../components/password_box.dart';
import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Background(
      child: Stack(
        children: <Widget>[
          Positioned(
            left: width * 0.25,
            top: height * 0.05,
            child: Text(
              "STUDY" '\n' "BUDDY",
              style: TextStyle(
                  fontSize: 80, color: Colors.white, fontFamily: 'Content'),
            ),
          ),
          Positioned(
            left: width * 0.1,
            top: height * 0.3,
            child: Text(
              "LOGIN",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Positioned(
            left: width * 0.1,
            top: height * 0.4,
            child: EmailBox(width: width),
          ),
          Positioned(
            left: width * 0.1,
            top: height * 0.5,
            child: PasswordBox(width: width),
          ),
        ],
      ),
    );
  }
}
