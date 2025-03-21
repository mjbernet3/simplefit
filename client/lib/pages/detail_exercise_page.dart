import 'package:client/components/detail_exercise/detail_distance.dart';
import 'package:client/components/detail_exercise/detail_lift.dart';
import 'package:client/components/detail_exercise/detail_timed.dart';
import 'package:client/components/shared/app_checkbox.dart';
import 'package:client/components/shared/action_buttons.dart';
import 'package:client/components/shared/app_icon_button.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/models/exercise/distance_cardio.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/models/exercise/timed_cardio.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:client/utils/app_error.dart';
import 'package:client/utils/constants.dart';
import 'package:client/utils/page_builder.dart';
import 'package:client/utils/validator.dart';
import 'package:client/view_models/detail_exercise_model.dart';
import 'package:client/view_models/detail_lift_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DetailExerciseModel model =
        Provider.of<DetailExerciseModel>(context, listen: false);

    ExerciseData exercise = model.exercise;

    return PageBuilder(
      appBar: AppBar(
        leading: AppIconButton(
          icon: const Icon(Icons.close),
          color: Constants.backgroundColor,
          elevation: 0.0,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      exercise.exercise.name,
                      style: const TextStyle(fontSize: 26.0),
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  const SizedBox(height: 14.0),
                  InputField(
                    controller: model.notesController,
                    hintText: 'Notes...',
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    numLines: 5,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      const Text(
                        'Warm-up Exercise',
                        style: TextStyle(
                          color: Constants.medEmphasis,
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(width: 15.0),
                      SizedBox(
                        height: 15.0,
                        width: 15.0,
                        child: AppCheckbox(
                          initialValue: exercise.isWarmUp,
                          onChanged: (bool value) => exercise.isWarmUp = value,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14.0),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: _buildExerciseForm(exercise),
                ),
              ),
            ),
            ActionButtons(
              onConfirmed: () => _saveExercise(context, exercise),
            ),
          ],
        );
      },
    );
  }

  Widget _buildExerciseForm(ExerciseData exercise) {
    String exerciseType = exercise.exercise.type;

    switch (exerciseType) {
      case Constants.lifting:
        return Provider<DetailLiftModel>(
          create: (context) => DetailLiftModel(weightLift: exercise as WeightLift),
          dispose: (context, model) => model.dispose(),
          child: DetailLift(),
        );
      case Constants.timed:
        return DetailTimed(exercise: exercise as TimedCardio);
      case Constants.distance:
        return DetailDistance(exercise: exercise as DistanceCardio);
      default:
        return const SizedBox.shrink();
    }
  }

  void _saveExercise(BuildContext context, ExerciseData exercise) {
    DetailExerciseModel model =
        Provider.of<DetailExerciseModel>(context, listen: false);

    exercise.notes = model.notesController.text;

    // TODO: Improve error handling
    try {
      Validator.validateExerciseData(exercise);
      Navigator.pop(context, exercise);
    } catch (e) {
      AppError.show(context, e.toString());
    }
  }
}
