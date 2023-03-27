import 'package:flutter/material.dart';

class AccountExists extends StatelessWidget {
  final bool login;
  final VoidCallback? press;

  const AccountExists({
    super.key,
    this.login = true,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don't have an Account? " : "Already have an Account? ",
          style: TextStyle(color: Colors.white,),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Sign in",
            style: TextStyle(color: Colors.black),
          ),
        )

      ],
    );
  }
}
