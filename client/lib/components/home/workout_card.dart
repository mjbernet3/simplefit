import 'package:client/utils/app_style.dart';
import 'package:client/models/workout/workout_preview.dart';
import 'package:flutter/material.dart';

class WorkoutCard extends StatelessWidget {
  final WorkoutPreview workoutPreview;
  final Function onPressed;
  final Function onRemovePressed;
  final bool isEditing;

  const WorkoutCard({
    Key key,
    @required this.workoutPreview,
    this.onPressed,
    this.onRemovePressed,
    this.isEditing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        isEditing
            ? Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: onRemovePressed,
                  child: Icon(
                    Icons.remove_circle,
                    color: AppStyle.dangerColor,
                  ),
                ),
              )
            : SizedBox.shrink(),
        Expanded(
          flex: 10,
          child: GestureDetector(
            onTap: onPressed,
            child: Card(
              color: AppStyle.dp3,
              shadowColor: AppStyle.backgroundColor,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      workoutPreview.name,
                      style: TextStyle(
                        color: AppStyle.highEmphasisText,
                        fontSize: 16.0,
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
