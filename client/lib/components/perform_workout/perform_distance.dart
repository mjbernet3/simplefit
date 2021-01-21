import 'package:client/components/perform_workout/previous_card.dart';
import 'package:client/components/perform_workout/vertical_stat_adjuster.dart';
import 'package:client/models/exercise/distance_cardio.dart';
import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class PerformDistance extends StatelessWidget {
  final DistanceCardio exercise;

  PerformDistance({this.exercise});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PreviousCard(
          stats: {
            'Distance': Text(exercise.distance.toStringAsFixed(1)),
            'Speed': Text(exercise.speed.toStringAsFixed(1)),
            'Advance': Text(exercise.shouldAdvance ? 'Yes' : 'No'),
          },
        ),
        SizedBox(height: 20.0),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: VerticalStatAdjuster(
                  stat: exercise.distance,
                  maxStat: Constants.maxExerciseDistance,
                  unit: 'Miles',
                  adjustAmount: 0.1,
                  onChanged: (double value) => exercise.distance = value,
                ),
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: VerticalStatAdjuster(
                  stat: exercise.speed,
                  maxStat: Constants.maxExerciseSpeed,
                  unit: 'MPH',
                  adjustAmount: 0.1,
                  onChanged: (double value) => exercise.speed = value,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
