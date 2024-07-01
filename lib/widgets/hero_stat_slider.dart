
import 'package:flutter/material.dart';

class HeroStatSlider extends StatelessWidget {
  const HeroStatSlider({
    Key? key,
    required this.statName,
    required this.statValue,
  }) : super(key: key);
  final String statName;
  final double statValue;

  @override
  Widget build(BuildContext context) {
      return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              statName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.blueAccent,
                inactiveTrackColor: Colors.blueAccent.withOpacity(0.3),
                thumbColor: Colors.blueAccent,
                overlayColor: Colors.blueAccent.withOpacity(0.2),
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Slider(
                max: 100,
                value: statValue,
                onChanged: (value){},
                label: statValue.round().toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}