import 'package:client/components/detail_exercise/detail_distance.dart';
import 'package:client/components/detail_exercise/detail_lift.dart';
import 'package:client/components/detail_exercise/detail_timed.dart';
import 'package:client/components/shared/app_checkbox.dart';
import 'package:client/components/shared/action_buttons.dart';
import 'package:client/components/shared/app_icon_button.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/models/exercise/exercise_data.dart';
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

    ExerciseData exerciseData = model.exercise;

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
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      exerciseData.exercise.name,
                      style: TextStyle(fontSize: 26.0),
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  SizedBox(height: 14.0),
                  InputField(
                    controller: model.notesController,
                    hintText: 'Notes...',
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    numLines: 5,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      Text(
                        'Warm-up Exercise',
                        style: TextStyle(
                          color: Constants.medEmphasis,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      SizedBox(
                        height: 15.0,
                        width: 15.0,
                        child: AppCheckbox(
                          initialValue: exerciseData.isWarmUp,
                          onChanged: (bool value) =>
                              exerciseData.isWarmUp = value,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.0),
            Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: _buildExerciseForm(exerciseData),
                ),
              ),
            ),
            ActionButtons(
              onConfirmed: () => _saveExerciseData(context, exerciseData),
            ),
          ],
        );
      },
    );
  }

  Widget _buildExerciseForm(ExerciseData exerciseData) {
    String exerciseType = exerciseData.exercise.type;

    switch (exerciseType) {
      case Constants.lifting:
        return Provider<DetailLiftModel>(
          create: (context) => DetailLiftModel(weightLift: exerciseData),
          dispose: (context, model) => model.dispose(),
          child: DetailLift(),
        );
      case Constants.timed:
        return DetailTimed(exerciseData);
      case Constants.distance:
        return DetailDistance(exerciseData);
      default:
        return Container();
    }
  }

  void _saveExerciseData(BuildContext context, ExerciseData exerciseData) {
    DetailExerciseModel model =
        Provider.of<DetailExerciseModel>(context, listen: false);

    exerciseData.notes = model.notesController.text;

    try {
      Validator.validateExerciseData(exerciseData);
      Navigator.pop(context, exerciseData);
    } catch (e) {
      AppError.show(context, e.message);
    }
  }
}
