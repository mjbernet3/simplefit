import 'package:client/components/perform_workout/previous_card.dart';
import 'package:client/components/perform_workout/stat_adjuster.dart';
import 'package:flutter/material.dart';

class PerformDistance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PreviousCard(
          stats: {
            "Distance": 10.0,
            "Speed": 5.0,
          },
          shouldAdvance: true,
        ),
        SizedBox(height: 20.0),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: StatAdjuster(
                  stat: 10.0,
                  unit: "Miles",
                  adjustAmount: 0.1,
                  onIncrement: () => print("increment"),
                  onDecrement: () => print("decrement"),
                ),
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: StatAdjuster(
                  stat: 5.2,
                  unit: "MPH",
                  adjustAmount: 0.1,
                  onIncrement: () => print("increment"),
                  onDecrement: () => print("decrement"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
