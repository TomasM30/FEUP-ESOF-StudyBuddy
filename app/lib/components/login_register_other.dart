import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OtherLoginRegister extends StatelessWidget {
  final String iconSrc;
  final VoidCallback? press;

  const OtherLoginRegister({
    super.key,
    required this.iconSrc,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Color(0x7cf3edd7),
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSrc,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
