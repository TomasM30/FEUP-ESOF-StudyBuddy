import 'package:flutter/material.dart';
import 'package:study_buddy_app/Screens/Welcome/welcome_screen.dart';
import 'package:study_buddy_app/Services/auth.dart';
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
              padding: const EdgeInsets.only(top: 35),
              child: Align(alignment: Alignment.topCenter,
                child: Text(
                  "SETTINGS",
                  style: TextStyle(
                      fontSize: 80,
                      color: Colors.white,
                      fontFamily: 'Content'),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
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
                          hintText: "Your email",
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
                            // Call the changeEmail() method
                            String message = await AuthService().changeEmail(
                                _email);
                            if (!mounted) return;
                            if (message == "unknown") {
                              message = "Please write something";
                            }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(message),
                              duration: Duration(seconds: 3),
                            ));
                            if (message == "Email updated") {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return WelcomeScreen();
                                  },
                                ),
                              );
                              setState(() {
                                showInputField = false;
                              });
                            }
                          },
                        ),
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
                  SizedBox(height: 30),
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
          ],
        ),
      ),
    );
  }
}
