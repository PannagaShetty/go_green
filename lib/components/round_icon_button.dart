import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final buttonIcon;
  final onPress;
  RoundIconButton({@required this.buttonIcon, @required this.onPress});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        buttonIcon,
        size: 14.0,
      ),
      shape: CircleBorder(),
      fillColor: Colors.deepOrange.shade300,
      constraints: BoxConstraints.tightFor(width: 25.0, height: 25.0),
      elevation: 0,
      onPressed: onPress,
    );
  }
}
