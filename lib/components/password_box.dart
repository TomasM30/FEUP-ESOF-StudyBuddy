import 'package:flutter/material.dart';

class PasswordBox extends StatelessWidget {
  final double width;


  const PasswordBox({required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.8,
      child: TextField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock),
          labelText: "Password",
          hintText: "Enter your Password address",
        ),
        onChanged: (value) {},
      ),
    );
  }
}