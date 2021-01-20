import 'package:client/components/manage_workout/chosen_exercise_card.dart';
import 'package:client/components/shared/listview_editor.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/utils/app_router.dart';
import 'package:client/view_models/manage_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChosenExercisesEditor extends StatelessWidget {
  final List<ExerciseData> exercises;

  ChosenExercisesEditor({this.exercises});

  @override
  Widget build(BuildContext context) {
    ManageWorkoutModel model =
        Provider.of<ManageWorkoutModel>(context, listen: false);

    return StreamBuilder<bool>(
      initialData: false,
      stream: model.isEditing,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        bool isEditing = snapshot.data;

        return ListViewEditor(
          isEditing: isEditing,
          title: 'Exercises',
          onAdd: () => _browseExercises(context),
          onEdit: () => model.setEditing(!isEditing),
          listView: ListView.builder(
            itemCount: exercises.length,
            itemBuilder: (BuildContext context, int index) {
              ExerciseData currentExercise = exercises[index];

              return ChosenExerciseCard(
                key: ObjectKey(currentExercise),
                exerciseData: currentExercise,
                onPressed: () => _detailExercise(
                  context,
                  index,
                  currentExercise,
                ),
                onRemovePressed: () => model.removeExerciseAt(index),
                isEditing: isEditing,
              );
            },
          ),
        );
      },
    );
  }

  void _browseExercises(BuildContext context) async {
    ManageWorkoutModel _model =
        Provider.of<ManageWorkoutModel>(context, listen: false);

    List<Exercise> chosenExercises = await Navigator.pushNamed(
      context,
      AppRouter.browseExercises,
    );

    if (chosenExercises != null) {
      _model.initExercises(chosenExercises);
    }
  }

  void _detailExercise(
      BuildContext context, int index, ExerciseData exerciseData) async {
    ManageWorkoutModel _model =
        Provider.of<ManageWorkoutModel>(context, listen: false);

    ExerciseData newExerciseData = await Navigator.pushNamed(
      context,
      AppRouter.detailExercise,
      arguments: exerciseData,
    );

    if (newExerciseData != null) {
      _model.updateExerciseAt(index, newExerciseData);
    }
  }
}
