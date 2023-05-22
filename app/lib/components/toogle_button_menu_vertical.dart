import 'package:flutter/material.dart';
import 'package:study_buddy_app/components/custom_button.dart';

class MenuButtonV extends StatefulWidget {
  final String iconSrc1;
  final String iconSrc2;
  final String iconSrc3;
  final String iconSrc4;
  final String iconSrc5;
  final String iconSrc6;
  final double width;
  final VoidCallback? press2;
  final VoidCallback? press3;
  final VoidCallback? press4;
  final VoidCallback? press5;
  final VoidCallback? press6;

  const MenuButtonV({
    Key? key,
    required this.iconSrc1,
    required this.iconSrc2,
    required this.iconSrc3,
    required this.iconSrc4,
    required this.iconSrc5,
    required this.iconSrc6,
    this.width = 60,
    this.press2,
    this.press3,
    this.press4,
    this.press5,
    this.press6
  }) : super(key: key);

  @override
  MenuButtonVState createState() => MenuButtonVState();
}

class MenuButtonVState extends State<MenuButtonV> {
  bool _showButtons = false;

  void _toggleShowButtons() {
    setState(() {
      _showButtons = !_showButtons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButtons(
          key: Key("toggleButton"),
          width: widget.width,
          iconSrc: widget.iconSrc1,
          press: () {
            _toggleShowButtons();
          },
        ),
        SizedBox(
          height: 5,
        ),
        if (_showButtons)
          Column(
            children: [
              CustomButtons(
                key: Key("studyModeBtn"),
                width: widget.width,
                iconSrc: widget.iconSrc2,
                press: widget.press2,
              ),
              SizedBox(
                height: 5,
              ),
              CustomButtons(
                width: widget.width,
                iconSrc: widget.iconSrc3,
                press: widget.press3,
              ),
              SizedBox(
                height: 5,
              ),
              CustomButtons(
                width: widget.width,
                iconSrc: widget.iconSrc4,
                press: widget.press4,
              ),
              SizedBox(
                height: 5,
              ),
              CustomButtons(
                width: widget.width,
                iconSrc: widget.iconSrc5,
                press: widget.press5,
              ),
              SizedBox(
                height: 5,
              ),
              CustomButtons(
                width: widget.width,
                iconSrc: widget.iconSrc6,
                press: widget.press6,
              ),
            ],
          ),
      ],
    );
  }
}
