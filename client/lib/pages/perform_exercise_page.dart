import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:client/components/perform_workout/perform_distance.dart';
import 'package:client/components/perform_workout/perform_lift.dart';
import 'package:client/components/perform_workout/perform_timed.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:client/utils/app_style.dart';
import 'package:client/utils/constant.dart';
import 'package:client/view_models/progress_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerformExercisePage extends StatefulWidget {
  @override
  _PerformExercisePageState createState() => _PerformExercisePageState();
}

class _PerformExercisePageState extends State<PerformExercisePage> {
  ProgressModel model;
  bool isResting = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    model = Provider.of<ProgressModel>(context, listen: false);
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
                      child: Text(
                        !isResting
                            ? currentExercise.exercise.name
                            : "Next: " + model.peekNext(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    AppDivider(),
                    Expanded(
                      child: !isResting
                          ? _buildExercise(currentExercise)
                          : CircularCountDownTimer(
                              isReverse: true,
                              isReverseAnimation: true,
                              width: MediaQuery.of(context).size.width * 0.75,
                              height: MediaQuery.of(context).size.height,
                              duration: currentExercise.rest,
                              fillColor: AppStyle.primaryColor,
                              color: AppStyle.dp4,
                              strokeWidth: 15.0,
                              textStyle: TextStyle(
                                color: Colors.white,
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
                          maintainAnimation: true,
                          maintainState: true,
                          child: RawMaterialButton(
                            padding: EdgeInsets.all(15.0),
                            fillColor: AppStyle.dp4,
                            shape: CircleBorder(),
                            child: Icon(
                              Icons.arrow_back_rounded,
                              size: 25.0,
                            ),
                            onPressed: () => _previous(),
                          ),
                        ),
                        Visibility(
                          visible:
                              !isResting && !(currentExercise is WeightLift),
                          child: RawMaterialButton(
                            padding: EdgeInsets.all(15.0),
                            fillColor: AppStyle.primaryColor,
                            shape: CircleBorder(),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: AppStyle.backgroundColor,
                              size: 40.0,
                            ),
                            onPressed: () => print('hello world'),
                          ),
                        ),
                        RawMaterialButton(
                          padding: EdgeInsets.all(15.0),
                          fillColor: AppStyle.dp4,
                          shape: CircleBorder(),
                          child: Icon(
                            model.hasNext()
                                ? Icons.arrow_forward_rounded
                                : Icons.flag_rounded,
                            size: 25.0,
                          ),
                          onPressed: () => model.hasNext()
                              ? _next(currentExercise)
                              : _finishWorkout(),
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
        return PerformDistance();
      case Constant.timed:
        return PerformTimed();
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
