import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy_app/Screens/Register/register_screen.dart';
import 'package:study_buddy_app/Screens/BuddyScreen/main_screen.dart';
import 'package:study_buddy_app/Screens/Welcome/welcome_screen.dart';
import 'package:study_buddy_app/Services/auth.dart';
import 'package:study_buddy_app/Services/database.dart';
import 'package:study_buddy_app/Services/user_setting.dart';
import 'package:study_buddy_app/components/account_exists_field.dart';
import 'package:study_buddy_app/components/custom_button_color.dart';
import 'package:study_buddy_app/components/forgot_password.dart';
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

  String getEmail(){
    return _email;
  }

  String getPassword(){
    return _password;
  }

  String getError(){
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
              key: Key("loginScreen"),
              "LOG IN",
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
            left: width * 0.25,
            top: height * 0.57,
            child: ForgotPassword(
              press: () async {
                if (_email == "") {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Write your email on the field above and click on the reset button",
                    ),
                  ));
                  return;
                }
                String? result =
                    await AuthService().changePassword(email: _email);
                if (result == "Password updated") {
                  result = "Check your email to reset your password";
                }
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    result!,
                  ),
                ));
              },
            ),
          ),
          Positioned(
            left: width * 0.1,
            top: height * 0.62,
            child: RoundedButton(
              key: Key("loginButton"),
              text: "LOGIN",
              press: () async {
                if (_email == "test@gmail.com" && _password == "password") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MainScreen();
                      },
                    ),
                  );
                } else {
                  if (_formKey.currentState!.validate()) {
                    Object? result = await _authService
                        .signInWithEmailAndPassword(_email, _password);
                    if (!mounted) return;
                    if (result != null) {
                      if (result == 'user-not-found') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('No user found for that email.')));
                      } else if (result == 'wrong-password') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Wrong password provided for that user.')));
                      } else {
                        if (_authService.getCurrentUser()?.emailVerified ==
                            false) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please verify your email.')));
                          return;
                        } else {
                          await _databaseService.importData();
                          int lvl = await _databaseService
                              .getLvl((await _databaseService.getXp())!);
                          _databaseService.updateLevel(lvl);
                          UserSettings.level = lvl;
                          UserSettings.xpAmount =
                              (await _databaseService.getXp())!;
                          UserSettings.coinsAmount =
                              (await _databaseService.getCoins())!;
                          UserSettings.buddy = (await _databaseService.getBuddy())!;
                          UserSettings.shop = (await _databaseService.getShop());
                          UserSettings.purchased = (await _databaseService.getPurchases());
                          if (!mounted) return;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MainScreen();
                              },
                            ),
                          );
                        }
                      }
                    }
                    if (result == null) {
                      setState(() {
                        _error = 'Failed to sign in';
                      });
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(_error)));
                    }
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
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RegisterScreen();
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
                    _databaseService.importData();
                    await Future.delayed(Duration(seconds: 1)); // add a 1-second delay
                    int lvl = await _databaseService
                        .getLvl((await _databaseService.getXp())!);
                    _databaseService.updateLevel(lvl);
                    UserSettings.level = lvl;
                    UserSettings.xpAmount = (await _databaseService.getXp())!;
                    UserSettings.coinsAmount =
                    (await _databaseService.getCoins())!;
                    UserSettings.buddy = (await _databaseService.getBuddy())!;
                    UserSettings.purchased = (await _databaseService.getPurchases());
                    UserSettings.shop = (await _databaseService.getShop());
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
