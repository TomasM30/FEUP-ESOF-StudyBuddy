import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomButtons extends StatelessWidget {
  final String iconSrc;
  final VoidCallback? press;

  const CustomButtons({
    super.key,
    required this.iconSrc,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SvgPicture.asset(
        iconSrc,
        width: 40,
        color: Color(0xd0f3edd7),
      ),
    );
  }
}
