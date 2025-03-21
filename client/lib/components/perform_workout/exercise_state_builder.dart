import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:client/components/perform_workout/perform_distance.dart';
import 'package:client/components/perform_workout/perform_lift.dart';
import 'package:client/components/perform_workout/perform_timed.dart';
import 'package:client/components/shared/info_tag.dart';
import 'package:client/components/shared/notes_dropdown.dart';
import 'package:client/models/exercise/distance_cardio.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/models/exercise/timed_cardio.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:client/utils/app_error.dart';
import 'package:client/utils/constants.dart';
import 'package:client/view_models/perform_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciseStateBuilder extends StatelessWidget {
  final ExerciseData exercise;
  final bool isResting;

  ExerciseStateBuilder({
    required this.exercise,
    required this.isResting,
  });

  @override
  Widget build(BuildContext context) {
    PerformWorkoutModel model =
        Provider.of<PerformWorkoutModel>(context, listen: false);

    if (isResting) {
      return Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 30.0,
              ),
              child: Text(
                model.getRestTitle(),
                style: const TextStyle(fontSize: 20.0),
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
          Expanded(
            child: CircularCountDownTimer(
              isReverse: true,
              isReverseAnimation: true,
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height,
              duration: model.getRest(),
              fillColor: Constants.primaryColor,
              ringColor: Constants.firstElevation,
              strokeWidth: 15.0,
              textStyle: const TextStyle(fontSize: 40.0),
              strokeCap: StrokeCap.round,
              onComplete: () => _next(context),
            ),
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
                exercise.exercise.name,
                style: const TextStyle(fontSize: 24.0),
                maxLines: 2,
                overflow: TextOverflow.fade,
              ),
            ),
            const SizedBox(width: 5.0),
            exercise.isWarmUp
                ? InfoTag(infoText: 'Warm Up')
                : const SizedBox.shrink(),
          ],
        ),
        const SizedBox(height: 5.0),
        NotesDropdown(
          notes: exercise.notes,
          onComplete: (String newNotes) => exercise.notes = newNotes,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: _buildExercise(context, exercise),
          ),
        ),
      ],
    );
  }

  Widget _buildExercise(BuildContext context, ExerciseData exercise) {
    String exerciseType = exercise.exercise.type;

    switch (exerciseType) {
      case Constants.lifting:
        return PerformLift(exercise: exercise as WeightLift);
      case Constants.distance:
        return PerformDistance(exercise: exercise as DistanceCardio);
      case Constants.timed:
        return PerformTimed(
          exercise: exercise as TimedCardio,
          onTimeExpired: () => _next(context),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  void _next(BuildContext context) {
    PerformWorkoutModel model =
        Provider.of<PerformWorkoutModel>(context, listen: false);

    // TODO: Improve error handling
    if (model.hasNext()) {
      model.next();
    } else {
      try {
        model.finishWorkout();
        Navigator.pop(context);
      } catch (e) {
        AppError.show(context, e.toString());
      }
    }
  }
}
