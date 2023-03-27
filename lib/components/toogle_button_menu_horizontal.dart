import 'package:flutter/material.dart';
import 'package:study_buddy_app/components/custom_button.dart';

class MenuButtonH extends StatefulWidget {
  final String iconSrc1;
  final String iconSrc2;
  final String iconSrc3;
  final String iconSrc4;
  final double width;
  final VoidCallback? press2;
  final VoidCallback? press3;
  final VoidCallback? press4;

  const MenuButtonH({
    Key? key,
    required this.iconSrc1,
    required this.iconSrc2,
    required this.iconSrc3,
    this.width = 60,
    this.press2,
    this.press3,
    required this.iconSrc4,
    this.press4,
  }) : super(key: key);

  @override
  MenuButtonHState createState() => MenuButtonHState();
}

class MenuButtonHState extends State<MenuButtonH> {
  bool _showButtons = false;

  void _toggleShowButtons() {
    setState(() {
      _showButtons = !_showButtons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomButtons(
          width: widget.width,
          iconSrc: widget.iconSrc1,
          press: () {
            _toggleShowButtons();
          },
        ),
        SizedBox(
          width: 5,
        ),
        if (_showButtons)
          Row(
            children: [
              CustomButtons(
                width: widget.width,
                iconSrc: widget.iconSrc2,
                press: widget.press2,
              ),
              SizedBox(
                width: 5,
              ),
              CustomButtons(
                width: widget.width,
                iconSrc: widget.iconSrc3,
                press: widget.press3,
              ),
              SizedBox(
                width: 5,
              ),
              CustomButtons(
                width: widget.width,
                iconSrc: widget.iconSrc4,
                press: widget.press4,
              ),
            ],
          ),
      ],
    );
  }
}
