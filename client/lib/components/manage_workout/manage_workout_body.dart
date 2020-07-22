import 'package:client/app_style.dart';
import 'package:client/components/manage_workout/chosen_exercise_listing.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/router.dart';
import 'package:client/view_models/manage_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageWorkoutBody extends StatefulWidget {
  @override
  _ManageWorkoutBodyState createState() => _ManageWorkoutBodyState();
}

class _ManageWorkoutBodyState extends State<ManageWorkoutBody> {
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
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
        ChosenExerciseListing(),
        RoundedButton(
          buttonText: Text(
            'Add Exercise',
            style: TextStyle(
              color: AppStyle.highEmphasisText,
            ),
          ),
          height: 30.0,
          color: AppStyle.dp4,
          borderColor: AppStyle.dp4,
          onPressed: () => _browseExercises(),
        ),
      ],
    );
  }

  void _browseExercises() async {
    List<Exercise> chosenExercises =
        await Navigator.pushNamed(context, Router.browser);

    if (chosenExercises != null) {
      ManageWorkoutModel model =
          Provider.of<ManageWorkoutModel>(context, listen: false);

      model.initExercises(chosenExercises);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
