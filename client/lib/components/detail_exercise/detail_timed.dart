import 'package:client/components/detail_exercise/detail_card.dart';
import 'package:client/models/exercise/timed_cardio.dart';
import 'package:flutter/material.dart';

class DetailTimed extends StatelessWidget {
  final TimedCardio timedData;

  DetailTimed(this.timedData);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          DetailCard(
            text: 'Cardio Time:',
            initialValue: timedData.time.toString(),
            onChanged: (String value) => timedData.time = int.parse(value),
          ),
          DetailCard(
            text: 'Cardio Speed:',
            initialValue: timedData.speed.toString(),
            onChanged: (String value) => timedData.speed = double.parse(value),
          ),
          DetailCard(
            text: 'Post-Cardio Rest: ',
            initialValue: timedData.rest.toString(),
            onChanged: (String value) => timedData.rest = int.parse(value),
          ),
        ],
      ),
    );
  }
}
