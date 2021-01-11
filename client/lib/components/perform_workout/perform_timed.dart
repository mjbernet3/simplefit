import 'package:client/components/perform_workout/countdown_timer.dart';
import 'package:client/components/perform_workout/horizontal_stat_adjuster.dart';
import 'package:client/components/perform_workout/previous_card.dart';
import 'package:client/models/exercise/timed_cardio.dart';
import 'package:client/utils/app_style.dart';
import 'package:client/utils/formatter.dart';
import 'package:flutter/material.dart';

class PerformTimed extends StatelessWidget {
  final TimedCardio exercise;
  final Function onTimeExpired;

  const PerformTimed({
    this.exercise,
    this.onTimeExpired,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PreviousCard(
          stats: {
            "Time": Text(
              Formatter.secondsToTime(exercise.time),
              style: TextStyle(
                color: AppStyle.highEmphasis,
              ),
            ),
            "Speed": Text(
              exercise.speed.toStringAsFixed(1),
              style: TextStyle(
                color: AppStyle.highEmphasis,
              ),
            ),
            "Advance": Text(
              "Yes",
              style: TextStyle(
                color: AppStyle.highEmphasis,
              ),
            ),
          },
        ),
        SizedBox(height: 20.0),
        Expanded(
          child: CountdownTimer(
            totalSeconds: exercise.time,
            onChanged: (int newTime) => exercise.time = newTime,
            onComplete: onTimeExpired,
          ),
        ),
        SizedBox(height: 20.0),
        HorizontalStatAdjuster(
          stat: exercise.speed,
          unit: "MPH",
          adjustAmount: 0.1,
          onChanged: (double newSpeed) => exercise.speed = newSpeed,
        ),
      ],
    );
  }
}
