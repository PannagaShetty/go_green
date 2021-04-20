import 'package:flutter/material.dart';
import 'package:gogreen/constants.dart';

class InputHeadingContainer extends StatelessWidget {
  final text;
  final image;
  final fontSize;
  InputHeadingContainer({this.image, this.text, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Padding(
        padding: kInputBoxHeadingPadding,
        child: Text(
          text,
          style: kInputBoxHeaderTextDecoration.copyWith(
              fontSize: fontSize == null ? 16.0 : fontSize),
          textAlign: TextAlign.center,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.green,
        image: DecorationImage(
            image: image,
            fit: BoxFit.fitWidth,
            colorFilter:
                ColorFilter.mode(Color(0x88000000), BlendMode.dstATop)),
        borderRadius: BorderRadius.only(
          topRight: const Radius.circular(15.0),
          topLeft: const Radius.circular(15.0),
        ),
      ),
    );
  }
}
