import 'package:client/app_style.dart';
import 'package:client/components/manage_workout/chosen_exercise_card.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/router.dart';
import 'package:client/view_models/manage_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChosenExerciseListing extends StatefulWidget {
  @override
  _ChosenExerciseListingState createState() => _ChosenExerciseListingState();
}

class _ChosenExerciseListingState extends State<ChosenExerciseListing> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Text(
            'Exercises',
            style: TextStyle(
              fontSize: 18.0,
              color: AppStyle.highEmphasisText,
            ),
          ),
        ),
        AppDivider(),
        Consumer<ManageWorkoutModel>(
          builder: (BuildContext context, ManageWorkoutModel model, _) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: model.exercises.length,
              itemBuilder: (BuildContext context, int index) {
                ExerciseData currentExercise = model.exercises[index];

                return ChosenExerciseCard(
                  exerciseData: currentExercise,
                  onPressed: () => Navigator.pushNamed(
                    context,
                    Router.exerciseDetail,
                    arguments: currentExercise,
                  ),
                  onRemovePressed: () => model.removeExerciseAt(index),
                  isEditing: isEditing,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
