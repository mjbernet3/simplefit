import 'package:client/app_style.dart';
import 'package:client/components/manage_workout/chosen_exercise_listing.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/services/workout_service.dart';
import 'package:client/utils/structures/response.dart';
import 'package:client/view_models/manage_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageWorkoutBody extends StatefulWidget {
  @override
  _ManageWorkoutBodyState createState() => _ManageWorkoutBodyState();
}

class _ManageWorkoutBodyState extends State<ManageWorkoutBody> {
  TextEditingController _nameController;
  TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InputField(
          controller: _nameController,
          labelText: 'Workout Name',
          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ),
        SizedBox(height: 12.0),
        InputField(
          controller: _notesController,
          hintText: 'Notes...',
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          maxLines: null,
        ),
        SizedBox(height: 24.0),
        Expanded(
          child: ChosenExerciseListing(),
        ),
        Column(
          children: <Widget>[
            AppDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RoundedButton(
                  buttonText: Text(
                    'Cancel',
                    style: TextStyle(color: AppStyle.highEmphasisText),
                  ),
                  height: 30.0,
                  color: AppStyle.dp4,
                  borderColor: AppStyle.dp4,
                  onPressed: () => Navigator.pop(context),
                ),
                RoundedButton(
                  buttonText: Text(
                    'Save Changes',
                    style: TextStyle(color: AppStyle.highEmphasisText),
                  ),
                  height: 30.0,
                  color: AppStyle.dp4,
                  borderColor: AppStyle.dp4,
                  onPressed: () => _createWorkout(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void _createWorkout() async {
    ManageWorkoutModel model =
        Provider.of<ManageWorkoutModel>(context, listen: false);

    String workoutName = _nameController.text;
    if (workoutName.isEmpty) {
      workoutName = 'New Workout';
    }

    Workout newWorkout = Workout(
      name: workoutName,
      notes: _notesController.text,
      exercises: model.getExercises(),
    );

    WorkoutService workoutService =
        Provider.of<WorkoutService>(context, listen: false);

    Response response = await workoutService.createWorkout(newWorkout);

    if (response.status == Status.FAILURE) {
      // TODO: Handle backend error
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
