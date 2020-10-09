import 'package:client/components/manage_workout/chosen_exercise_listing.dart';
import 'package:client/components/shared/action_buttons.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/models/workout/workout_preview.dart';
import 'package:client/services/workout_service.dart';
import 'package:client/utils/structures/response.dart';
import 'package:client/view_models/manage_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageWorkoutPage extends StatefulWidget {
  final WorkoutPreview preview;
  final bool isEdit;

  ManageWorkoutPage({this.preview}) : isEdit = preview != null;

  @override
  _ManageWorkoutPageState createState() => _ManageWorkoutPageState();
}

class _ManageWorkoutPageState extends State<ManageWorkoutPage> {
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
    WorkoutService workoutService =
        Provider.of<WorkoutService>(context, listen: false);

    ManageWorkoutModel model =
        Provider.of<ManageWorkoutModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? 'Edit Workout' : 'Create Workout',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: FutureBuilder<Response>(
          future: widget.isEdit
              ? workoutService.getWorkout(widget.preview.id)
              : null,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Workout workout = snapshot.data.data;

              _nameController.text = workout.name;
              _notesController.text = workout.notes;

              model.setExercises(workout.exercises);
            }

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
                ActionButtons(
                  onConfirmed: () =>
                      widget.isEdit ? _updateWorkout() : _createWorkout(),
                ),
              ],
            );
          },
        ),
      ),
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

  void _updateWorkout() async {
    ManageWorkoutModel model =
        Provider.of<ManageWorkoutModel>(context, listen: false);

    String workoutName = _nameController.text;
    if (workoutName.isEmpty) {
      workoutName = 'Updated Workout';
    }

    Workout updatedWorkout = Workout(
      id: widget.preview.id,
      name: workoutName,
      notes: _notesController.text,
      exercises: model.getExercises(),
    );

    WorkoutService workoutService =
        Provider.of<WorkoutService>(context, listen: false);

    Response response = await workoutService.updateWorkout(updatedWorkout);

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
