import 'package:client/utils/app_style.dart';
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
              color: AppStyle.firstElevation,
            ),
            Container(
              height: 35.0,
              width: 35.0,
              decoration: BoxDecoration(
                color: AppStyle.firstElevation,
                shape: BoxShape.circle,
                border: Border.all(color: AppStyle.primaryColor),
              ),
            ),
          ],
        ),
        SizedBox(width: 20.0),
        Text(
          exerciseName,
          style: TextStyle(
            color: AppStyle.highEmphasis,
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }
}
