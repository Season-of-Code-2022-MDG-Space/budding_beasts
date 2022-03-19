// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String text;

  // ignore: use_key_in_widget_constructors
  const CustomButton({required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 200,
      child: RaisedButton(
        onPressed: onTap(),
        child: Text(
          text,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
