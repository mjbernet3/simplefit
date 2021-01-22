import 'package:client/components/detail_exercise/stat_card.dart';
import 'package:client/models/exercise/distance_cardio.dart';
import 'package:flutter/material.dart';

class DetailDistance extends StatelessWidget {
  final DistanceCardio exercise;

  DetailDistance({this.exercise});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        StatCard(
          title: 'Cardio Distance:',
          inputUnit: 'miles',
          initialValue: exercise.distance.toString(),
          onChanged: (String value) => exercise.distance = double.parse(value),
          isPrecise: true,
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
