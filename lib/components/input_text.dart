import 'package:flutter/material.dart';
import 'package:gogreen/constants.dart';

class InputText extends StatelessWidget {
  final text;
  InputText({this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        text,
        style: kInputBoxTextDecoration,
      ),
    );
  }
}
