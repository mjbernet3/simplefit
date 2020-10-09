import 'package:client/components/exercise_detail/base_detail.dart';
import 'package:client/components/exercise_detail/detail_card.dart';
import 'package:client/models/exercise/distance_cardio.dart';
import 'package:flutter/material.dart';

class DistanceDetail extends StatelessWidget {
  final DistanceCardio distanceData;

  const DistanceDetail(this.distanceData);

  @override
  Widget build(BuildContext context) {
    return BaseDetail(
      exerciseData: distanceData,
      child: Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
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
                onChanged: (String value) =>
                    distanceData.speed = double.parse(value),
              ),
              DetailCard(
                text: 'Post-Cardio Rest: ',
                initialValue: distanceData.rest.toString(),
                onChanged: (String value) =>
                    distanceData.rest = int.parse(value),
              ),
              DetailCard(
                text: 'Times to Repeat:',
                initialValue: distanceData.repeat.toString(),
                onChanged: (String value) =>
                    distanceData.repeat = int.parse(value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
