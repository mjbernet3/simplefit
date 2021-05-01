import 'package:client/components/browse_exercises/exercises_editor.dart';
import 'package:client/utils/constants.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/utils/app_router.dart';
import 'package:client/services/exercise_service.dart';
import 'package:client/view_models/browse_exercises_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrowseExercisesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ExerciseService exerciseService =
        Provider.of<ExerciseService>(context, listen: false);
    BrowseExercisesModel model =
        Provider.of<BrowseExercisesModel>(context, listen: false);

    return StreamBuilder(
      initialData: <Exercise>[],
      stream: model.chosenExercises,
      builder: (BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
        List<Exercise> chosenExercises = snapshot.data;

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<List<Exercise>>(
              stream: exerciseService.exercises,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Exercise>> snapshot) {
                if (snapshot.hasData) {
                  List<Exercise> exercises = snapshot.data;

                  if (exercises.isEmpty) {
                    return Expanded(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: const Text(
                                  'Choose Exercises',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                              const Divider(),
                            ],
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'You have no exercises.',
                                  style: TextStyle(
                                    color: Constants.medEmphasis,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                RoundedButton(
                                  buttonText: 'Add Exercise',
                                  height: 30.0,
                                  color: Constants.secondElevation,
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    AppRouter.manageExercise,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Expanded(
                    child: ExercisesEditor(
                      exercises: exercises,
                      chosenExercises: chosenExercises,
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
            chosenExercises.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Divider(),
                      RoundedButton(
                        buttonText: 'Add ${chosenExercises.length} Exercises',
                        height: 30.0,
                        color: Constants.secondElevation,
                        onPressed: () =>
                            Navigator.pop(context, chosenExercises),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
