import 'package:client/components/detail_exercise/stat_card.dart';
import 'package:client/models/exercise/distance_cardio.dart';
import 'package:flutter/material.dart';

class DetailDistance extends StatelessWidget {
  final DistanceCardio distanceData;

  DetailDistance(this.distanceData);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        StatCard(
          title: 'Cardio Distance:',
          inputUnit: 'miles',
          initialValue: distanceData.distance.toString(),
          onChanged: (String value) =>
              distanceData.distance = double.parse(value),
          isPrecise: true,
        ),
        StatCard(
          title: 'Cardio Speed:',
          inputUnit: 'mph',
          initialValue: distanceData.speed.toString(),
          onChanged: (String value) => distanceData.speed = double.parse(value),
          isPrecise: true,
        ),
        StatCard(
          title: 'Post-Cardio Rest:',
          inputUnit: 'seconds',
          initialValue: distanceData.rest.toString(),
          onChanged: (String value) => distanceData.rest = int.parse(value),
        ),
      ],
    );
  }
}
