import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //total height of the screen
    return Container(
      height: size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/register&login_screen_bg.png"),
            fit: BoxFit.cover),
      ),
      child: child,
    );
  }
}