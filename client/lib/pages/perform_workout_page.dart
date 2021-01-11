import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:client/components/perform_workout/perform_distance.dart';
import 'package:client/components/perform_workout/perform_lift.dart';
import 'package:client/components/perform_workout/perform_timed.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/notes_dropdown.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/utils/app_style.dart';
import 'package:client/utils/constant.dart';
import 'package:client/view_models/perform_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerformWorkoutPage extends StatefulWidget {
  @override
  _PerformWorkoutPageState createState() => _PerformWorkoutPageState();
}

class _PerformWorkoutPageState extends State<PerformWorkoutPage> {
  PerformWorkoutModel model;
  bool isResting = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    model = Provider.of<PerformWorkoutModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: StreamBuilder<ExerciseData>(
            stream: model.exerciseStream,
            builder:
                (BuildContext context, AsyncSnapshot<ExerciseData> snapshot) {
              if (snapshot.hasData) {
                ExerciseData currentExercise = snapshot.data;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppStyle.firstElevation,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 30.0),
                        child: Text(
                          !isResting
                              ? currentExercise.exercise.name
                              : "Next: " + model.peekNext(),
                          style: TextStyle(
                            color: AppStyle.highEmphasis,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    !isResting
                        ? NotesDropdown(
                            notes: currentExercise.notes,
                            onComplete: (String newNotes) =>
                                currentExercise.notes = newNotes,
                          )
                        : SizedBox.shrink(),
                    Expanded(
                      child: !isResting
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                              child: _buildExercise(currentExercise),
                            )
                          : CircularCountDownTimer(
                              isReverse: true,
                              isReverseAnimation: true,
                              width: MediaQuery.of(context).size.width * 0.75,
                              height: MediaQuery.of(context).size.height,
                              duration: currentExercise.rest,
                              fillColor: AppStyle.primaryColor,
                              color: AppStyle.firstElevation,
                              strokeWidth: 15.0,
                              textStyle: TextStyle(
                                color: AppStyle.highEmphasis,
                                fontSize: 40.0,
                              ),
                              onComplete: () => _next(currentExercise),
                            ),
                    ),
                    AppDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: model.hasPrevious(),
                          maintainSize: true,
                          maintainState: true,
                          maintainAnimation: true,
                          child: RawMaterialButton(
                            padding: EdgeInsets.all(15.0),
                            fillColor: AppStyle.firstElevation,
                            shape: CircleBorder(),
                            child: Icon(
                              Icons.arrow_back_rounded,
                              size: 25.0,
                              color: AppStyle.highEmphasis,
                            ),
                            onPressed: () => _previous(),
                          ),
                        ),
                        model.hasNext()
                            ? RawMaterialButton(
                                padding: EdgeInsets.all(15.0),
                                fillColor: AppStyle.firstElevation,
                                shape: CircleBorder(),
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 25.0,
                                  color: AppStyle.highEmphasis,
                                ),
                                onPressed: () => _next(currentExercise),
                              )
                            : RawMaterialButton(
                                padding: EdgeInsets.all(15.0),
                                fillColor: AppStyle.primaryColor,
                                shape: CircleBorder(),
                                child: Icon(
                                  Icons.flag_rounded,
                                  size: 25.0,
                                  color: AppStyle.backgroundColor,
                                ),
                                onPressed: () => _finishWorkout(),
                              ),
                      ],
                    ),
                  ],
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildExercise(ExerciseData exercise) {
    String type = exercise.exercise.type;

    switch (type) {
      case Constant.lifting:
        return PerformLift();
      case Constant.distance:
        return PerformDistance(exercise: exercise);
      case Constant.timed:
        return PerformTimed(
          exercise: exercise,
          onTimeExpired: () =>
              model.hasNext() ? _next(exercise) : _finishWorkout(),
        );
      default:
        return Container();
    }
  }

  void _previous() {
    if (isResting) {
      setState(() => isResting = false);
    } else {
      model.previous();
    }
  }

  void _next(ExerciseData currentExercise) {
    if (!isResting && currentExercise.rest > 0) {
      setState(() => isResting = true);
    } else {
      setState(() => isResting = false);
      model.next();
    }
  }

  void _finishWorkout() {
    print("save and exit");
  }
}
