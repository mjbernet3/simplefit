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
    ExerciseService _exerciseService =
        Provider.of<ExerciseService>(context, listen: false);
    BrowseExercisesModel _model =
        Provider.of<BrowseExercisesModel>(context, listen: false);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        StreamBuilder<List<Exercise>>(
          stream: _exerciseService.exercises,
          builder:
              (BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
            if (snapshot.hasData) {
              List<Exercise> _exercises = snapshot.data;

              if (_exercises.isEmpty) {
                return Expanded(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              'Choose Exercises',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'You have no exercises.',
                              style: TextStyle(
                                color: Constants.medEmphasis,
                              ),
                            ),
                            SizedBox(height: 10.0),
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
                child: ExercisesEditor(exercises: _exercises),
              );
            }

            return Container();
          },
        ),
        StreamBuilder<List<Exercise>>(
          stream: _model.chosenExercisesStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              List<Exercise> _chosenExercises = snapshot.data;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Divider(),
                  RoundedButton(
                    buttonText: 'Add ${_chosenExercises.length} Exercises',
                    height: 30.0,
                    color: Constants.secondElevation,
                    onPressed: () => Navigator.pop(context, _chosenExercises),
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      ],
    );
  }
}
