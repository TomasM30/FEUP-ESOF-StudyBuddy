import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  final VoidCallback? press;

  const ForgotPassword({
    super.key,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Forgot your password? ",
          style: TextStyle(color: Colors.white,),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            "Reset",
            style: TextStyle(color: Colors.black),
          ),
        )

      ],
    );
  }
}
