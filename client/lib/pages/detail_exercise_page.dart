import 'package:client/components/detail_exercise/detail_distance.dart';
import 'package:client/components/detail_exercise/detail_lift.dart';
import 'package:client/components/detail_exercise/detail_timed.dart';
import 'package:client/components/shared/app_checkbox.dart';
import 'package:client/components/shared/action_buttons.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/utils/constants.dart';
import 'package:client/components/shared/page_builder.dart';
import 'package:client/view_models/detail_exercise_model.dart';
import 'package:client/view_models/detail_lift_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DetailExerciseModel _model =
        Provider.of<DetailExerciseModel>(context, listen: false);

    ExerciseData _exerciseData = _model.exerciseData;

    return PageBuilder(
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
                      _exerciseData.exercise.name,
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                  SizedBox(height: 14.0),
                  InputField(
                    controller: _model.notesController,
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
                          initialValue: _exerciseData.isWarmUp,
                          onChanged: (bool value) =>
                              _exerciseData.isWarmUp = value,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: _buildExerciseForm(_exerciseData),
              ),
            ),
            ActionButtons(
              onConfirmed: () => {
                _exerciseData.notes = _model.notesController.text,
                Navigator.pop(context, _exerciseData),
              },
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
          create: (context) => DetailLiftModel(exerciseData),
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
}
