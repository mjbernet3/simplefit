import 'package:client/components/shared/removable_card.dart';
import 'package:client/utils/constants.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  final Exercise exercise;
  final Function onPressed;
  final Function onRemovePressed;
  final bool isEditing;

  ExerciseCard({
    @required this.exercise,
    this.onPressed,
    this.onRemovePressed,
    this.isEditing = false,
  });

  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return RemovableCard(
      color: Constants.secondElevation,
      borderColor: _selected && !widget.isEditing
          ? Constants.highEmphasis
          : Constants.secondElevation,
      onPressed: () => {
        if (!widget.isEditing)
          {
            setState(() => _selected = !_selected),
          },
        widget.onPressed(_selected),
      },
      onRemovePressed: widget.onRemovePressed,
      isRemovable: widget.isEditing,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                _buildExerciseIcon(),
                color: Constants.lowEmphasis,
              ),
            ),
            const SizedBox(width: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.exercise.name,
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 5.0),
                Text(
                  widget.exercise.bodyPart ?? widget.exercise.type,
                  style: const TextStyle(
                    color: Constants.medEmphasis,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
