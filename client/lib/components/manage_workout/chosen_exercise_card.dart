import 'package:client/components/shared/removable_card.dart';
import 'package:client/utils/constants.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:flutter/material.dart';

class ChosenExerciseCard extends StatelessWidget {
  final ExerciseData exerciseData;
  final Function onPressed;
  final Function onRemovePressed;
  final bool isEditing;

  ChosenExerciseCard({
    @required Key key,
    @required this.exerciseData,
    this.onPressed,
    this.onRemovePressed,
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
              exerciseData.exercise.name,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 5.0),
            Text(
              exerciseData.exercise.bodyPart ?? exerciseData.exercise.type,
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
