import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomButtons extends StatelessWidget {
  final String iconSrc;
  final VoidCallback? press;
  final double width;

  const CustomButtons({
    super.key,
    required this.iconSrc,
    this.press,
    this.width = 40,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SvgPicture.asset(
        iconSrc,
        width: width,
      ),
    );
  }
}
