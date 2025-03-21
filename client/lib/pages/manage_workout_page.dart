import 'package:client/components/manage_workout/chosen_exercises_builder.dart';
import 'package:client/components/shared/action_buttons.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/utils/app_error.dart';
import 'package:client/utils/page_builder.dart';
import 'package:client/utils/constants.dart';
import 'package:client/view_models/manage_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageWorkoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManageWorkoutModel model =
        Provider.of<ManageWorkoutModel>(context, listen: false);

    return PageBuilder(
      appBar: AppBar(),
      body: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InputField(
              controller: model.nameController,
              maxLength: Constants.maxWorkoutNameLength,
              textInputAction: TextInputAction.next,
              labelText: 'Workout Name',
            ),
            SizedBox(height: 12.0),
            InputField(
              controller: model.notesController,
              hintText: 'Notes...',
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              numLines: 5,
            ),
            SizedBox(height: 24.0),
            Expanded(
              child: ChosenExercisesBuilder(),
            ),
            ActionButtons(
              confirmText:
                  model.isEditMode ? 'Update Workout' : 'Create Workout',
              onConfirmed: () => _saveWorkout(context),
            ),
          ],
        );
      },
    );
  }

  void _saveWorkout(BuildContext context) {
    ManageWorkoutModel model =
        Provider.of<ManageWorkoutModel>(context, listen: false);

    // TODO: Improve error handling
    try {
      model.saveWorkout();
      Navigator.pop(context);
    } catch (e) {
      AppError.show(context, e.toString());
    }
  }
}
