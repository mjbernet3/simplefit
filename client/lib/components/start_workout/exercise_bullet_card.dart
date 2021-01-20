import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class ExerciseBulletCard extends StatelessWidget {
  final String exerciseName;

  const ExerciseBulletCard({@required this.exerciseName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 50.0,
              width: 3.0,
              color: Constants.firstElevation,
            ),
            Container(
              height: 35.0,
              width: 35.0,
              decoration: BoxDecoration(
                color: Constants.firstElevation,
                shape: BoxShape.circle,
                border: Border.all(color: Constants.primaryColor),
              ),
            ),
          ],
        ),
        SizedBox(width: 20.0),
        Expanded(
          child: Text(
            exerciseName,
            style: TextStyle(fontSize: 18.0),
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
        ),
      ],
    );
  }
}
