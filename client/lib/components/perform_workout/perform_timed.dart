import 'package:client/components/shared/countdown_timer.dart';
import 'package:client/components/shared/horizontal_stat_adjuster.dart';
import 'package:client/components/perform_workout/previous_card.dart';
import 'package:client/models/exercise/timed_cardio.dart';
import 'package:client/utils/constants.dart';
import 'package:client/utils/formatter.dart';
import 'package:flutter/material.dart';

class PerformTimed extends StatelessWidget {
  final TimedCardio exercise;
  final Function onTimeExpired;

  PerformTimed({
    this.exercise,
    this.onTimeExpired,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PreviousCard(
          stats: {
            'Time': Text(Formatter.secondsToHourString(exercise.time)),
            'Speed': Text(exercise.speed.toStringAsFixed(1)),
            'Rest': Text(Formatter.secondsToMinuteString(exercise.rest)),
          },
        ),
        const SizedBox(height: 10.0),
        Expanded(
          child: CountdownTimer(
            totalSeconds: exercise.time,
            maxSeconds: Constants.maxExerciseTime,
            onChanged: (int newTime) => exercise.time = newTime,
            onComplete: onTimeExpired,
          ),
        ),
        const SizedBox(height: 10.0),
        HorizontalStatAdjuster(
          stat: exercise.speed,
          maxStat: Constants.maxExerciseSpeed,
          unit: 'MPH',
          adjustAmount: 0.1,
          onChanged: (double newSpeed) => exercise.speed = newSpeed,
        ),
      ],
    );
  }
}
