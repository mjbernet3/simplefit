import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:client/components/perform_workout/perform_distance.dart';
import 'package:client/components/perform_workout/perform_lift.dart';
import 'package:client/components/perform_workout/perform_timed.dart';
import 'package:client/components/shared/notes_dropdown.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/utils/app_error.dart';
import 'package:client/utils/constants.dart';
import 'package:client/view_models/perform_lift_model.dart';
import 'package:client/view_models/perform_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciseStateBuilder extends StatelessWidget {
  final ExerciseData currentExercise;

  ExerciseStateBuilder({this.currentExercise});

  @override
  Widget build(BuildContext context) {
    PerformWorkoutModel model =
        Provider.of<PerformWorkoutModel>(context, listen: false);

    return StreamBuilder<bool>(
      initialData: false,
      stream: model.isResting,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        bool isResting = snapshot.data;

        if (isResting) {
          return Column(
            children: [
              Text(
                "Next: " + model.nextExerciseName,
                style: const TextStyle(fontSize: 24.0),
                maxLines: 2,
                overflow: TextOverflow.fade,
              ),
              CircularCountDownTimer(
                isReverse: true,
                isReverseAnimation: true,
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height,
                duration: currentExercise.rest,
                fillColor: Constants.primaryColor,
                color: Constants.firstElevation,
                strokeWidth: 15.0,
                textStyle: const TextStyle(fontSize: 40.0),
                onComplete: () => _next(context),
              ),
            ],
          );
        }

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    currentExercise.exercise.name,
                    style: const TextStyle(fontSize: 24.0),
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                  ),
                ),
                const SizedBox(width: 5.0),
                currentExercise.isWarmUp
                    ? Card(
                        color: Constants.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2.0,
                            horizontal: 4.0,
                          ),
                          child: const Text(
                            'Warm-Up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Constants.backgroundColor,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            NotesDropdown(
              notes: currentExercise.notes,
              onComplete: (String newNotes) => currentExercise.notes = newNotes,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: _buildExercise(context, currentExercise),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildExercise(BuildContext context, ExerciseData exercise) {
    String exerciseType = exercise.exercise.type;

    switch (exerciseType) {
      case Constants.lifting:
        return Provider<PerformLiftModel>(
          create: (context) => PerformLiftModel(weightLift: exercise),
          dispose: (context, model) => model.dispose(),
          child: PerformLift(),
        );
      case Constants.distance:
        return PerformDistance(exercise: exercise);
      case Constants.timed:
        return PerformTimed(
          exercise: exercise,
          onTimeExpired: () => _next(context),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  void _next(BuildContext context) async {
    PerformWorkoutModel model =
        Provider.of<PerformWorkoutModel>(context, listen: false);

    if (model.hasNext()) {
      model.next();
    } else {
      try {
        await model.finishWorkout();
        Navigator.pop(context);
      } catch (e) {
        AppError.show(context, e.message);
      }
    }
  }
}
