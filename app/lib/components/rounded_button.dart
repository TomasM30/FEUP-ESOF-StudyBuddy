import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback? press;
  final Color bgcolor, textColor;

  const RoundedButton({
    super.key,
    required this.text,
    required this.press,
    this.bgcolor = const Color(0xff251b00),
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //total height of the screen
    return SizedBox(
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                backgroundColor: bgcolor,
            ),
            onPressed: press,
            child: Transform.scale(
              scale: 1.7,
              child: Text(
                text,
                style: TextStyle(color: textColor),
              ),
            )),
      ),
    );
  }
}
