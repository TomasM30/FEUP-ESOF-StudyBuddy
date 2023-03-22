import 'package:flutter/material.dart';

class EmailBox extends StatelessWidget {
  final double width;

  const EmailBox({required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.8,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          icon: Icon(Icons.email),
          labelText: "Email",
          hintText: "Enter your Email address",
        ),
        onChanged: (value) {},
      ),
    );
  }
}