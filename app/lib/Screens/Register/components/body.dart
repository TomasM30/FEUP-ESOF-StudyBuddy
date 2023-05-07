import 'package:flutter/material.dart';
import 'package:study_buddy_app/Screens/Login/login_screen.dart';
import 'package:study_buddy_app/Screens/Welcome/welcome_screen.dart';
import 'package:study_buddy_app/Screens/BuddyScreen/main_screen.dart';
import 'package:study_buddy_app/Services/auth.dart';
import 'package:study_buddy_app/Services/database.dart';
import 'package:study_buddy_app/components/account_exists_field.dart';
import 'package:study_buddy_app/components/custom_button_color.dart';
import 'package:study_buddy_app/components/login_register_other.dart';
import 'package:study_buddy_app/components/rounded_button.dart';
import 'package:study_buddy_app/components/rounded_input_field.dart';
import 'package:study_buddy_app/components/rounded_password_field.dart';

import 'background.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _error = '';

  String getEmail() {
    return _email;
  }
  String getPassword() {
    return _password;
  }
  String getError() {
    return _error;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Background(
      child: Stack(
        children: [
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
            top: height * 0.35,
            child: Text(
              key: Key("signupScreen"),
              "SIGN UP",
              style: TextStyle(
                  fontSize: 30, color: Colors.white, fontFamily: "Content"),
            ),
          ),
          Positioned(
            left: width * 0.1,
            top: height * 0.4,
            child: Form(
              key: _formKey,
              child: RoundedInputField(
                hintText: "Your email",
                icon: Icons.email,
                onChanged: (value) {
                  setState(() {
                    _email = value.trim();
                  });
                },
              ),
            ),
          ),
          Positioned(
            left: width * 0.1,
            top: height * 0.49,
            child: RoundedPasswordField(
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Positioned(
            left: width * 0.1,
            top: height * 0.6,
            child: RoundedButton(
              key: Key("signupButton"),
              text: "SIGNUP",
              press: () async {
                if (_formKey.currentState!.validate()) {
                  Object? result = await _authService
                      .registerWithEmailAndPassword(_email, _password);
                  if (!mounted) return;
                  if (result != null) {
                    if (result == 'weak-password') {
                      _error = 'The password provided is too weak.';
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('The password provided is too weak.')));
                    } else if (result == 'email-already-in-use') {
                      _error = 'The account already exists for that email.';
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'The account already exists for that email.')));
                    } else {
                      await _authService.verifyEmail();
                      if (!mounted) return;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Account created.')));
                    }
                  } else {
                    setState(() {
                      _error = 'Failed to sign up';
                    });
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(_error)));
                  }
                }
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
          Positioned(
            top: height * 0.74,
            left: width * 0.25,
            right: width * 0.25,
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Color(0xd0f3edd7),
                    thickness: 1.5,
                  ),
                ),
                SizedBox(width: width * 0.02),
                Text(
                  "OR",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: width * 0.02),
                Expanded(
                  child: Divider(
                    color: Color(0xd0f3edd7),
                    thickness: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: height * 0.8,
            left: width * 0.425,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OtherLoginRegister(
                  iconSrc: "assets/icons/google.svg",
                  press: () async {
                    await _authService.signInWithGoogle();
                    await _databaseService.importData();
                    await Future.delayed(Duration(seconds: 1)); // add a 1-second delay
                    _databaseService.importData();
                    await Future.delayed(Duration(seconds: 1)); // add a 1-second delay
                    _databaseService.buildData();
                    await _databaseService.updateLastLogin(DateTime.now().day.toString() +
                        '/' +
                        DateTime.now().month.toString() +
                        '/' +
                        DateTime.now().year.toString());
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
                ),
              ],
            ),
          ),
          Positioned(
            top: height * 0.01,
            left: width * 0.03,
            child: CustomButtonsColor(
              iconSrc: "assets/icons/go-back-simple.svg",
              press: () {
                if (!mounted) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WelcomeScreen();
                    },
                  ),
                );
              },
              color: Color(0xd0f3edd7),
            ),
          ),
        ],
      ),
    );
  }
}
