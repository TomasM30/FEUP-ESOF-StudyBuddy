import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomButtonsColor extends StatelessWidget {
  final String iconSrc;
  final VoidCallback? press;
  final Color color;
  final double width;


  const CustomButtonsColor({
    super.key,
    required this.iconSrc,
    this.press,
    required this.color,
    this.width = 40,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SvgPicture.asset(
        iconSrc,
        width: width,
        color: color,
      ),
    );
  }
}
