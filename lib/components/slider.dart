import 'package:flutter/material.dart';
import 'package:gogreen/components/round_icon_button.dart';

class CustomSlider extends StatelessWidget {
  CustomSlider(
      {this.value,
      this.onPress,
      this.max,
      this.min,
      this.icon,
      this.division,
      this.unit,
      this.onPressMinus,
      this.onPressPlus});
  final max;
  final min;
  final value;
  final onPress;
  final division;
  final unit;
  final icon;
  final onPressPlus;
  final onPressMinus;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: <Widget>[
          // Icon(icon),
          // RoundIconButton(buttonIcon: Icons.remove, onPress: onPressMinus),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.green[700],
                inactiveTrackColor: Colors.green[400],
                trackShape: RoundedRectSliderTrackShape(),
                trackHeight: 2.0,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                thumbColor: Colors.green,
                overlayColor: Colors.green.withAlpha(32),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
                tickMarkShape: RoundSliderTickMarkShape(),
                activeTickMarkColor: Colors.green[700],
                inactiveTickMarkColor: Colors.green[400],
                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                valueIndicatorColor: Colors.green,
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: Slider(
                value: value,
                min: 0,
                max: 100,
                divisions: 4,
                label: value >= 100
                    ? 'Very High'
                    : value >= 75
                        ? 'High'
                        : value >= 50
                            ? 'Moderate'
                            : value >= 25
                                ? 'Less'
                                : 'Very Less',
                onChanged: onPress,
              ),
            ),
          ),
          // RoundIconButton(buttonIcon: Icons.add, onPress: onPressPlus),
          // Text(
          //   value > 80
          //       ? 'Very High'
          //       : value > 60
          //           ? 'High'
          //           : value > 40
          //               ? 'Moderate'
          //               : value > 20
          //                   ? 'Less'
          //                   : 'Very Less',
          // ),
        ],
      ),
    );
  }
}
