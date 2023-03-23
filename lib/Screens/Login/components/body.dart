import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy_app/Screens/Register/register_screen.dart';
import 'package:study_buddy_app/Screens/main_screen.dart';
import 'package:study_buddy_app/Services/auth.dart';
import 'package:study_buddy_app/components/rounded_button.dart';
import 'package:study_buddy_app/components/rounded_input_field.dart';
import 'package:study_buddy_app/components/rounded_password_field.dart';
import '../../../components/account_exists_field.dart';
import 'background.dart';

class Body extends StatefulWidget{
  const Body({Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}


class BodyState  extends State<Body> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _error = '';

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
              text: "LOGIN",
              press: () async {
                if (_formKey.currentState!.validate()) {
                  UserCredential? result = await _authService.signInWithEmailAndPassword(_email, _password);
                  if (!mounted) return;
                  if(result != null){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MainScreen();
                        },
                      ),
                    );
                  }
                  if (result == null) {
                    setState(() {
                      _error = 'Failed to sign in';
                    });
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
          Divider(
            thickness: 6,
            height: 6,
          )
        ],
      ),
    );
  }
}
