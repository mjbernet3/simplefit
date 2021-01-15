import 'package:client/utils/constants.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
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
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        widget.isEditing
            ? Expanded(
                flex: 1,
                child: Center(
                  child: GestureDetector(
                    onTap: widget.onRemovePressed,
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
            onTap: () => {
              if (!widget.isEditing)
                {
                  setState(() => selected = !selected),
                },
              widget.onPressed(selected),
            },
            child: Card(
              elevation: 2.0,
              color: Constants.secondElevation,
              shadowColor: Constants.backgroundColor,
              shape: selected && !widget.isEditing
                  ? RoundedRectangleBorder(
                      side: BorderSide(color: Constants.highEmphasis),
                      borderRadius: BorderRadius.circular(4.0),
                    )
                  : null,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        _buildExerciseIcon(),
                        color: Constants.lowEmphasis,
                      ),
                    ),
                    SizedBox(width: 14.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.exercise.name,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          widget.exercise.bodyPart ?? widget.exercise.type,
                          style: TextStyle(
                            color: Constants.medEmphasis,
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

  IconData _buildExerciseIcon() {
    switch (widget.exercise.type) {
      case Constants.lifting:
        return Icons.fitness_center;
      case Constants.timed:
        return Icons.query_builder;
      case Constants.distance:
        return Icons.directions_run;
      default:
        return null;
    }
  }
}
