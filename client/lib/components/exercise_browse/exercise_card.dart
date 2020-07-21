import 'package:client/app_style.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/utils/constant.dart';
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
                    onTap: () => widget.onRemovePressed(widget.exercise.id),
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
            onTap: () => {
              widget.onPressed(widget.exercise, !selected),
              if (!widget.isEditing)
                {
                  setState(() => selected = !selected),
                }
            },
            child: Card(
              color: AppStyle.dp6,
              shadowColor: AppStyle.backgroundColor,
              shape: selected && !widget.isEditing
                  ? RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(4.0),
                    )
                  : null,
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
                          widget.exercise.name,
                          style: TextStyle(
                            color: AppStyle.highEmphasisText,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          widget.exercise.bodyPart ?? widget.exercise.type,
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
    switch (widget.exercise.type) {
      case Constant.lifting:
        return Icon(Icons.fitness_center, color: AppStyle.lowEmphasisText);
      case Constant.timed:
        return Icon(Icons.query_builder, color: AppStyle.lowEmphasisText);
      case Constant.distance:
        return Icon(Icons.directions_run, color: AppStyle.lowEmphasisText);
      default:
        return null;
    }
  }
}
