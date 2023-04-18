import 'package:flutter/material.dart';

import 'text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const RoundedPasswordField({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        key: Key("passwordField"),
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Your password",
          icon: Icon(Icons.lock),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
