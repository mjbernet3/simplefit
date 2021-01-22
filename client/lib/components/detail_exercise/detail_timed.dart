import 'package:client/components/detail_exercise/stat_card.dart';
import 'package:client/models/exercise/timed_cardio.dart';
import 'package:flutter/material.dart';

class DetailTimed extends StatelessWidget {
  final TimedCardio exercise;

  DetailTimed({this.exercise});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        StatCard(
          title: 'Cardio Time:',
          inputUnit: 'seconds',
          initialValue: exercise.time.toString(),
          onChanged: (String value) => exercise.time = int.parse(value),
        ),
        StatCard(
          title: 'Cardio Speed:',
          inputUnit: 'mph',
          initialValue: exercise.speed.toString(),
          onChanged: (String value) => exercise.speed = double.parse(value),
          isPrecise: true,
        ),
        StatCard(
          title: 'Post-Cardio Rest:',
          inputUnit: 'seconds',
          initialValue: exercise.rest.toString(),
          onChanged: (String value) => exercise.rest = int.parse(value),
        ),
      ],
    );
  }
}
