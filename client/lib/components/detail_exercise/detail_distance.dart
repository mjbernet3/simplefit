import 'package:client/components/detail_exercise/detail_card.dart';
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
        DetailCard(
          text: 'Cardio Distance:',
          initialValue: distanceData.distance.toString(),
          onChanged: (String value) =>
              distanceData.distance = double.parse(value),
        ),
        DetailCard(
          text: 'Cardio Speed:',
          initialValue: distanceData.speed.toString(),
          onChanged: (String value) => distanceData.speed = double.parse(value),
        ),
        DetailCard(
          text: 'Post-Cardio Rest: ',
          initialValue: distanceData.rest.toString(),
          onChanged: (String value) => distanceData.rest = int.parse(value),
        ),
      ],
    );
  }
}
