import 'package:client/components/shared/removable_card.dart';
import 'package:client/utils/constants.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final Function onPressed;
  final GestureTapCallback onRemovePressed;
  final bool isEditing;
  final bool isSelected;

  ExerciseCard({
    required this.exercise,
    required this.onPressed,
    required this.onRemovePressed,
    this.isEditing = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return RemovableCard(
      color: Constants.secondElevation,
      borderColor: isSelected && !isEditing
          ? Constants.highEmphasis
          : Constants.secondElevation,
      onPressed: () => onPressed(!isSelected),
      onRemovePressed: onRemovePressed,
      isRemovable: isEditing,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Row(
          children: <Widget>[
            Icon(
              _buildExerciseIcon(),
              color: Constants.lowEmphasis,
            ),
            const SizedBox(width: 15.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    exercise.name,
                    style: const TextStyle(fontSize: 16.0),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    exercise.bodyPart ?? exercise.type,
                    style: const TextStyle(
                      color: Constants.medEmphasis,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _buildExerciseIcon() {
    switch (exercise.type) {
      case Constants.lifting:
        return Icons.fitness_center;
      case Constants.timed:
        return Icons.query_builder;
      case Constants.distance:
        return Icons.directions_run;
      default:
        return Icons.help_outline;
    }
  }
}
