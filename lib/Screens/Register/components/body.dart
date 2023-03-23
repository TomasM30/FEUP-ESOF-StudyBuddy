import 'package:flutter/material.dart';
import 'package:study_buddy_app/Screens/Login/login_screen.dart';
import 'package:study_buddy_app/components/account_exists_field.dart';
import 'package:study_buddy_app/components/rounded_button.dart';
import 'package:study_buddy_app/components/rounded_input_field.dart';
import 'package:study_buddy_app/components/rounded_password_field.dart';

import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Background(
      child: Stack(
        children: [
          Positioned(
            child: Divider(
              height: 20,
              thickness: 5,
              color: Colors.black,
            ),
          ),
          Positioned(
            left: width*0.25,
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
              "SIGN UP",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Positioned(
            left: width * 0.1,
            top: height * 0.4,
            child: Form(
              child: RoundedInputField(
                hintText: "Your email",
                icon: Icons.email,
                onChanged: (value) {

                },
              ),
            ),
          ),
          Positioned(
            left: width * 0.1,
            top: height * 0.49,
            child: RoundedPasswordField(
              onChanged: (value) {

              },
            ),
          ),
          Positioned(
            left: width * 0.1,
            top: height * 0.6,
            child: RoundedButton(
              text: "SIGNUP",
              press: () {
              },
              textColor: Colors.black,
              bgcolor: Color(0xd0f3edd7),
            ),
          ),
          Positioned(
            left: width * 0.25,
            top: height * 0.7,
            child: AccountExists(
              login: false,
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
            ),
          ),
          
        ],
      ),
    );
  }
}
