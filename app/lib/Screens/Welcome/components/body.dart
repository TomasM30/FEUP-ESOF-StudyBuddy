import 'package:flutter/material.dart';
import 'package:study_buddy_app/Screens/Login/login_screen.dart';
import 'package:study_buddy_app/Screens/Register/register_screen.dart';


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
            left: -33, // Adjust the position as needed
            top: height * 0.17, // Adjust the position as needed
            child: Image.asset(
              "assets/images/study_buddy_logo.png",
              width: 460,
            ),
          ),

          Positioned(
            left: width * 0.1,
            top: height * 0.60,
            child: RoundedButton(
              text: "LOGIN",
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
            top: height * 0.69,
            child: RoundedButton(
              text: "SIGN UP",
              press: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return RegisterScreen();
                  },
                ));
              },
              textColor: Colors.black,
              bgcolor: Color(0xfff3edd7),
            ),
          ),
        ],
      ),
    );
  }
}
