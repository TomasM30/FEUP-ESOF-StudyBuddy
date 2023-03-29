import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final VoidCallback? press;
  final String text;

  const ClickableText({
    Key? key,
    required this.press,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
