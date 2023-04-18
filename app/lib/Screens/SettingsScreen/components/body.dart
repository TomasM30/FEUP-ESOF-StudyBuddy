import 'package:flutter/material.dart';
import 'package:study_buddy_app/Screens/BuddyScreen/main_screen.dart';
import 'package:study_buddy_app/Screens/Welcome/welcome_screen.dart';
import 'package:study_buddy_app/Services/auth.dart';
import 'package:study_buddy_app/components/custom_button_color.dart';
import 'package:study_buddy_app/components/custom_clickable_text.dart';
import 'package:study_buddy_app/components/rounded_button.dart';
import 'package:study_buddy_app/components/rounded_input_field.dart';
import 'background.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  final AuthService _authService = AuthService();
  bool showInputField = false;
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 55),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "SETTINGS",
                  style: TextStyle(
                      fontSize: 80, color: Colors.white, fontFamily: 'Content'),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3841,
              left: MediaQuery.of(context).size.width * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Visibility(
                    visible: !showInputField,
                    child: RoundedButton(
                      text: 'Reset Email',
                      textColor: Colors.black,
                      bgcolor: Color(0xd0f3edd7),
                      press: () {
                        setState(() {
                          showInputField = true;
                        });
                      },
                    ),
                  ),
                  Visibility(
                    visible: showInputField,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        RoundedInputField(
                          hintText: "New email",
                          onChanged: (value) {
                            setState(() {
                              _email = value.trim();
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        RoundedButton(
                            text: 'Submit',
                            textColor: Colors.black,
                            bgcolor: Color(0xd0f3edd7),
                            press: () async {
                              String result =
                                  await _authService.changeEmail(_email);
                              if (result == 'Email updated') {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    "Check your email to verify your new email address",
                                  ),
                                ));
                                if (!mounted) return;
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return WelcomeScreen();
                                    },
                                  ),
                                );
                                _authService.signOut();
                              } else {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    result,
                                  ),
                                ));
                              }
                            }),
                        SizedBox(height: 10),
                        ClickableText(
                          text: 'Go back',
                          press: () {
                            setState(() {
                              showInputField = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RoundedButton(
                      text: 'Reset Password',
                      textColor: Colors.black,
                      bgcolor: Color(0xd0f3edd7),
                      press: () async {
                        _authService.signOut();
                        String? result = await AuthService().changePassword();
                        if (result == "Password updated") {
                          result = "Check your email to reset your password";
                        }
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            result!,
                          ),
                        ));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return WelcomeScreen();
                            },
                          ),
                        );
                      }),
                  SizedBox(height: 10),
                  RoundedButton(
                    text: 'Logout',
                    textColor: Colors.black,
                    bgcolor: Color(0xd0f3edd7),
                    press: () {
                      _authService.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return WelcomeScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.01,
              left: MediaQuery.of(context).size.width * 0.03,
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
          ],
        ),
      ),
    );
  }
}
