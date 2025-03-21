import 'package:client/components/shared/removable_card.dart';
import 'package:client/utils/constants.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:flutter/material.dart';

class ChosenExerciseCard extends StatelessWidget {
  final ExerciseData exercise;
  final GestureTapCallback onPressed;
  final GestureTapCallback onRemovePressed;
  final bool isEditing;

  ChosenExerciseCard({
    required Key key,
    required this.exercise,
    required this.onPressed,
    required this.onRemovePressed,
    this.isEditing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RemovableCard(
      onPressed: onPressed,
      onRemovePressed: onRemovePressed,
      isRemovable: isEditing,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              exercise.exercise.name,
              style: const TextStyle(fontSize: 16.0),
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
            const SizedBox(height: 5.0),
            Text(
              exercise.exercise.bodyPart ?? exercise.exercise.type,
              style: const TextStyle(
                color: Constants.medEmphasis,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
