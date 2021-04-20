import 'package:flutter/material.dart';
import 'package:gogreen/constants.dart';

class CustomButton extends StatelessWidget {
  final onPress;
  final inputText;
  CustomButton({this.onPress, this.inputText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPaddingButton,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        color: Colors.green,
        onPressed: onPress,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Text(inputText),
        textColor: Colors.white,
      ),
    );
  }
}
