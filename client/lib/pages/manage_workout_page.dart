import 'package:client/components/manage_workout/chosen_exercises_builder.dart';
import 'package:client/components/shared/action_buttons.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/components/shared/linear_loading_indicator.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/utils/app_error.dart';
import 'package:client/view_models/manage_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageWorkoutPage extends StatefulWidget {
  @override
  _ManageWorkoutPageState createState() => _ManageWorkoutPageState();
}

class _ManageWorkoutPageState extends State<ManageWorkoutPage> {
  ManageWorkoutModel _model;
  TextEditingController _nameController;
  TextEditingController _notesController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _notesController = TextEditingController();
    _model = Provider.of<ManageWorkoutModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          _model.isEditMode ? 'Edit Workout' : 'Create Workout',
          style: TextStyle(fontSize: 18.0),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.5),
          child: LinearLoadingIndicator(isLoading: _model.isLoading),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: StreamBuilder<Workout>(
          stream: _model.workoutStream,
          builder: (BuildContext context, AsyncSnapshot<Workout> snapshot) {
            if (snapshot.hasData) {
              Workout workout = snapshot.data;

              _nameController.text = workout.name;
              _notesController.text = workout.notes;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  InputField(
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    labelText: 'Workout Name',
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
                    child: ChosenExercisesBuilder(),
                  ),
                  ActionButtons(
                    onConfirmed: () => _saveWorkout(context),
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  void _saveWorkout(BuildContext context) async {
    try {
      await _model.saveWorkout(_nameController.text, _notesController.text);
      Navigator.pop(context);
    } catch (e) {
      AppError.show(context, e.message);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
