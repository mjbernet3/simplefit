import 'package:client/components/manage_workout/chosen_exercises_editor.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/utils/app_router.dart';
import 'package:client/view_models/manage_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChosenExercisesBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManageWorkoutModel model =
        Provider.of<ManageWorkoutModel>(context, listen: false);

    return StreamBuilder<List<ExerciseData>>(
      stream: model.exercises,
      builder:
          (BuildContext context, AsyncSnapshot<List<ExerciseData>> snapshot) {
        if (snapshot.hasData) {
          List<ExerciseData> exercises = snapshot.data;

          if (exercises.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: const Text(
                    'Exercises',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                const Divider(),
                RoundedButton(
                  buttonText: 'Add Exercise',
                  height: 30.0,
                  onPressed: () => _browseExercises(context),
                ),
              ],
            );
          }

          return ChosenExercisesEditor(exercises: exercises);
        }

        return const SizedBox.shrink();
      },
    );
  }

  void _browseExercises(BuildContext context) async {
    ManageWorkoutModel model =
        Provider.of<ManageWorkoutModel>(context, listen: false);

    List<Exercise> chosenExercises = await Navigator.pushNamed(
      context,
      AppRouter.browseExercises,
    );

    if (chosenExercises != null) {
      model.initExercises(chosenExercises);
    }
  }
}
