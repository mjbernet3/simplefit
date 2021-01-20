import 'package:client/components/detail_exercise/stat_card.dart';
import 'package:client/models/exercise/timed_cardio.dart';
import 'package:flutter/material.dart';

class DetailTimed extends StatelessWidget {
  final TimedCardio timedData;

  DetailTimed(this.timedData);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        StatCard(
          title: 'Cardio Time:',
          inputUnit: 'seconds',
          initialValue: timedData.time.toString(),
          onChanged: (String value) => timedData.time = int.parse(value),
        ),
        StatCard(
          title: 'Cardio Speed:',
          inputUnit: 'mph',
          initialValue: timedData.speed.toString(),
          onChanged: (String value) => timedData.speed = double.parse(value),
          isPrecise: true,
        ),
        StatCard(
          title: 'Post-Cardio Rest:',
          inputUnit: 'seconds',
          initialValue: timedData.rest.toString(),
          onChanged: (String value) => timedData.rest = int.parse(value),
        ),
      ],
    );
  }
}
