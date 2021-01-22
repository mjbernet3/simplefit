import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:client/components/perform_workout/perform_distance.dart';
import 'package:client/components/perform_workout/perform_lift.dart';
import 'package:client/components/perform_workout/perform_timed.dart';
import 'package:client/components/shared/app_icon_button.dart';
import 'package:client/components/shared/notes_dropdown.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/utils/app_error.dart';
import 'package:client/utils/constants.dart';
import 'package:client/components/shared/page_builder.dart';
import 'package:client/view_models/perform_lift_model.dart';
import 'package:client/view_models/perform_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerformWorkoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PerformWorkoutModel _model =
        Provider.of<PerformWorkoutModel>(context, listen: false);

    return PageBuilder(
      appBar: AppBar(
        leading: AppIconButton(
          icon: Icon(Icons.close),
          color: Constants.backgroundColor,
          elevation: 0.0,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: (BuildContext context) {
        return StreamBuilder<ExerciseData>(
          stream: _model.exercise,
          builder:
              (BuildContext context, AsyncSnapshot<ExerciseData> snapshot) {
            if (snapshot.hasData) {
              ExerciseData _currentExercise = snapshot.data;

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: StreamBuilder<bool>(
                      initialData: false,
                      stream: _model.isResting,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        bool _isResting = snapshot.data;

                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    !_isResting
                                        ? _currentExercise.exercise.name
                                        : "Next: " + _model.nextExerciseName,
                                    style: TextStyle(fontSize: 24.0),
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                !_isResting && _currentExercise.isWarmUp
                                    ? Card(
                                        color: Constants.primaryColor,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2.0,
                                            horizontal: 4.0,
                                          ),
                                          child: Text(
                                            'Warm-Up',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Constants.backgroundColor,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ],
                            ),
                            !_isResting
                                ? NotesDropdown(
                                    notes: _currentExercise.notes,
                                    onComplete: (String newNotes) =>
                                        _currentExercise.notes = newNotes,
                                  )
                                : SizedBox.shrink(),
                            Expanded(
                              child: !_isResting
                                  ? Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.0),
                                      child: _buildExercise(
                                          context, _currentExercise),
                                    )
                                  : CircularCountDownTimer(
                                      isReverse: true,
                                      isReverseAnimation: true,
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      duration: _currentExercise.rest,
                                      fillColor: Constants.primaryColor,
                                      color: Constants.firstElevation,
                                      strokeWidth: 15.0,
                                      textStyle: TextStyle(fontSize: 40.0),
                                      onComplete: () => _next(context),
                                    ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: _model.hasPrevious(),
                        maintainSize: true,
                        maintainState: true,
                        maintainAnimation: true,
                        child: AppIconButton(
                          icon: const Icon(Icons.arrow_back_rounded),
                          padding: const EdgeInsets.all(15.0),
                          color: Constants.firstElevation,
                          shape: const CircleBorder(),
                          onPressed: () => _previous(context),
                        ),
                      ),
                      AppIconButton(
                        icon: _model.hasNext()
                            ? const Icon(Icons.arrow_forward_rounded)
                            : const Icon(
                                Icons.flag_rounded,
                                color: Constants.backgroundColor,
                              ),
                        color: _model.hasNext()
                            ? Constants.firstElevation
                            : Constants.primaryColor,
                        padding: const EdgeInsets.all(15.0),
                        shape: const CircleBorder(),
                        onPressed: () => _next(context),
                      ),
                    ],
                  ),
                ],
              );
            }

            return Container();
          },
        );
      },
    );
  }

  Widget _buildExercise(BuildContext context, ExerciseData exercise) {
    String type = exercise.exercise.type;

    switch (type) {
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
        return Container();
    }
  }

  void _previous(BuildContext context) {
    PerformWorkoutModel _model =
        Provider.of<PerformWorkoutModel>(context, listen: false);

    if (_model.hasPrevious()) {
      _model.previous();
    } else {
      Navigator.pop(context);
    }
  }

  void _next(BuildContext context) async {
    PerformWorkoutModel _model =
        Provider.of<PerformWorkoutModel>(context, listen: false);

    if (_model.hasNext()) {
      _model.next();
    } else {
      try {
        await _model.finishWorkout();
        Navigator.pop(context);
      } catch (e) {
        AppError.show(context, e.message);
      }
    }
  }
}
