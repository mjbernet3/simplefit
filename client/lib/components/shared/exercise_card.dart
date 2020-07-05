import 'package:client/app_style.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final Function onPressed;
  final Function onRemovePressed;
  final bool isEditing;

  ExerciseCard({
    this.exercise,
    this.onPressed,
    this.onRemovePressed,
    this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        isEditing
            ? Expanded(
                flex: 1,
                child: Center(
                  child: GestureDetector(
                    onTap: () => onRemovePressed(exercise.id),
                    child: Icon(
                      Icons.remove_circle,
                      color: AppStyle.dangerColor,
                    ),
                  ),
                ),
              )
            : SizedBox.shrink(),
        Expanded(
          flex: 10,
          child: GestureDetector(
            onTap: () => onPressed(exercise),
            child: Card(
              color: AppStyle.dp6,
              shadowColor: AppStyle.backgroundColor,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _buildExerciseIcon(),
                    ),
                    SizedBox(width: 14.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          exercise.name,
                          style: TextStyle(
                            color: AppStyle.highEmphasisText,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          exercise.bodyPart ?? exercise.type,
                          style: TextStyle(
                            color: AppStyle.medEmphasisText,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
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

  Widget _buildExerciseIcon() {
    switch (exercise.type) {
      case 'Timed Cardio':
        return Icon(Icons.query_builder, color: AppStyle.lowEmphasisText);
      case 'Distance Cardio':
        return Icon(Icons.directions_run, color: AppStyle.lowEmphasisText);
      default:
        return Icon(Icons.fitness_center, color: AppStyle.lowEmphasisText);
    }
  }
}
