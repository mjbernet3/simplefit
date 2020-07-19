import 'package:client/app_style.dart';
import 'package:client/components/manage_workout/chosen_exercise_card.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/router.dart';
import 'package:client/state_models/manage_workout_model.dart';
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
  bool isEditing = false;

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
          controller: _descriptionController,
          labelText: 'Workout Description',
          onSubmitted: (_) => FocusScope.of(context).unfocus(),
        ),
        SizedBox(height: 24.0),
        Align(
          alignment: Alignment.center,
          child: Text(
            'Exercises',
            style: TextStyle(
              fontSize: 18.0,
              color: AppStyle.highEmphasisText,
            ),
          ),
        ),
        AppDivider(),
        Consumer<ManageWorkoutModel>(
          builder: (BuildContext context, ManageWorkoutModel model, _) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: model.exercises.length,
              itemBuilder: (BuildContext context, int index) {
                return ChosenExerciseCard(
                  exerciseData: model.exercises[index],
                  onPressed: () async {
                    ExerciseData updatedExercise = await Navigator.pushNamed(
                      context,
                      Router.exerciseDetail,
                      arguments: model.exercises[index],
                    );

                    model.updateExercise(updatedExercise, index);
                  },
                  onRemovePressed: () => model.removeExerciseAt(index),
                  isEditing: isEditing,
                );
              },
            );
          },
        ),
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
        SizedBox(height: 24.0),
//        InputField(
//          controller: _notesController,
//          keyboardType: TextInputType.multiline,
//          textInputAction: TextInputAction.newline,
//          maxLines: null,
//        ),
      ],
    );
  }

  void _browseExercises() async {
    List<Exercise> chosenExercises =
        await Navigator.pushNamed(context, Router.browser);

    /*
        The barrierDismissible property does not allow a return type other than
        null, so this checks for that user interaction on prev popped route
     */
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
