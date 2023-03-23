import 'package:flutter/material.dart';
import 'package:study_buddy_app/Screens/Login/login_screen.dart';

import '../../../components/rounded_button.dart';
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
            top: height * 0.25,
            child: Text(
              "STUDY" '\n' "BUDDY",
              style: TextStyle(
                  fontSize: 80, color: Colors.white, fontFamily: 'Content'),
            ),
          ),
          Positioned(
            left: width * 0.1,
            top: height * 0.57,
            child: RoundedButton(
              text: "Login",
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
              bgcolor: Color(0xdb4b3900),
            ),
          ),
          Positioned(
            left: width * 0.1,
            top: height * 0.66,
            child: RoundedButton(
              text: "Register",
              press: () {},
              textColor: Colors.black,
              bgcolor: Color(0xfff3edd7),
            ),
          ),
        ],
      ),
    );
  }
}
