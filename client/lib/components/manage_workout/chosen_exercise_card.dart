import 'package:client/utils/constants.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:flutter/material.dart';

class ChosenExerciseCard extends StatelessWidget {
  final ExerciseData exerciseData;
  final Function onPressed;
  final Function onRemovePressed;
  final bool isEditing;

  const ChosenExerciseCard({
    Key key,
    this.exerciseData,
    this.onPressed,
    this.onRemovePressed,
    this.isEditing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        isEditing
            ? Expanded(
                flex: 1,
                child: Center(
                  child: GestureDetector(
                    onTap: onRemovePressed,
                    child: Icon(
                      Icons.remove_circle,
                      color: Constants.dangerColor,
                    ),
                  ),
                ),
              )
            : SizedBox.shrink(),
        Expanded(
          flex: 10,
          child: GestureDetector(
            onTap: onPressed,
            child: Card(
              color: Constants.firstElevation,
              shadowColor: Constants.backgroundColor,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      exerciseData.exercise.name,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      exerciseData.exercise.bodyPart ??
                          exerciseData.exercise.type,
                      style: TextStyle(
                        color: Constants.medEmphasis,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
