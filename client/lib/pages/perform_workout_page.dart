import 'package:client/components/perform_workout/exercise_state_builder.dart';
import 'package:client/components/shared/app_icon_button.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/utils/app_error.dart';
import 'package:client/utils/constants.dart';
import 'package:client/utils/page_builder.dart';
import 'package:client/view_models/perform_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerformWorkoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PerformWorkoutModel model =
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
          stream: model.exercise,
          builder:
              (BuildContext context, AsyncSnapshot<ExerciseData> snapshot) {
            if (snapshot.hasData) {
              ExerciseData currentExercise = snapshot.data;

              return StreamBuilder<bool>(
                  initialData: false,
                  stream: model.isResting,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    bool isResting = snapshot.data;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ExerciseStateBuilder(
                            exercise: currentExercise,
                            isResting: isResting,
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppIconButton(
                                icon: const Icon(Icons.arrow_back_rounded),
                                padding: const EdgeInsets.all(15.0),
                                color: Constants.firstElevation,
                                shape: const CircleBorder(),
                                onPressed: () => _previous(context),
                              ),
                              AppIconButton(
                                icon: model.hasNext()
                                    ? const Icon(Icons.arrow_forward_rounded)
                                    : const Icon(
                                        Icons.flag_rounded,
                                        color: Constants.backgroundColor,
                                      ),
                                color: model.hasNext()
                                    ? Constants.firstElevation
                                    : Constants.primaryColor,
                                padding: const EdgeInsets.all(15.0),
                                shape: const CircleBorder(),
                                onPressed: () => _next(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            }

            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  void _previous(BuildContext context) {
    PerformWorkoutModel model =
        Provider.of<PerformWorkoutModel>(context, listen: false);

    if (model.hasPrevious()) {
      model.previous();
    } else {
      Navigator.pop(context);
    }
  }

  void _next(BuildContext context) {
    PerformWorkoutModel model =
        Provider.of<PerformWorkoutModel>(context, listen: false);

    if (model.hasNext()) {
      model.next();
    } else {
      try {
        model.finishWorkout();
        Navigator.pop(context);
      } catch (e) {
        AppError.show(context, e.message);
      }
    }
  }
}
