import 'package:flutter/material.dart';
import 'package:gogreen/constants.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'dart:math' as _math;

class RadialProgress extends StatefulWidget {
  final double goalCompleted;
  RadialProgress({
    this.goalCompleted,
  });

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  var percentage;

  AnimationController _radialProgressAnimationController;
  Animation<double> _progressAnimation;
  Animation<double> _progressAnimationPercentage;
  final Duration fadeInDuration = Duration(milliseconds: 500);
  final Duration fillDuration = Duration(seconds: 1, milliseconds: 500);

  double progressDegrees = 0;
  double progressPercentage = 0;
  var count = 0;

  @override
  void initState() {
    super.initState();
    _radialProgressAnimationController =
        AnimationController(vsync: this, duration: fillDuration);
    _progressAnimation = Tween(begin: 0.0, end: 360.0).animate(CurvedAnimation(
        parent: _radialProgressAnimationController, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {
          progressDegrees = widget.goalCompleted * _progressAnimation.value;
        });
      });

    _progressAnimationPercentage = Tween(begin: 0.0, end: 100.0).animate(
        CurvedAnimation(
            parent: _radialProgressAnimationController, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {
          progressPercentage =
              widget.goalCompleted * _progressAnimationPercentage.value;
        });
      });

    _radialProgressAnimationController.forward();
  }

  @override
  void dispose() {
    _radialProgressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            CustomPaint(
              child: Container(
                height: 60.0,
                width: 60.0,
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Text('555555555'),
              ),
              painter: RadialPainter(
                  progressInDegrees: progressDegrees,
                  progressColor: progressPercentage),
            ),
            Container(
              height: 60.0,
              width: 60.0,
              child: Center(
                child: Text(
                  '${progressPercentage.round()}%',
                  style: TextStyle(
                      color: kInputTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RadialPainter extends CustomPainter {
  double progressInDegrees;
  final progressColor;

  RadialPainter({this.progressInDegrees, this.progressColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7.0;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(-90), math.radians(360), false, paint);

    Paint progressPaint = Paint()
      ..color = progressColor <= 20
          ? Colors.yellow.shade700
          : progressColor <= 40
              ? Colors.orangeAccent
              : progressColor <= 60
                  ? Colors.green
                  : progressColor <= 60
                      ? Colors.redAccent
                      : Colors.red
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7.0;

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(-90),
        math.radians(progressInDegrees),
        false,
        progressPaint);

    var dotPaint = Paint()
      ..color = progressColor <= 20
          ? Colors.yellow.shade700
          : progressColor <= 40
              ? Colors.orangeAccent
              : progressColor <= 60
                  ? Colors.green
                  : progressColor <= 60
                      ? Colors.redAccent
                      : Colors.red;

    var dx = center.dx +
        size.width /
            2 *
            _math.cos(
                math.radians(_math.pi / 2 + (-90) + progressInDegrees + 1.5));
    var dy = center.dy +
        size.width /
            2 *
            _math.sin(math
                .radians(_math.pi / 2 + (-90) + progressInDegrees - 0.5 + 1.5));
    Offset handler = Offset(dx, dy);
    canvas.drawCircle(handler, 5, dotPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
