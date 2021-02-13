import 'package:client/components/browse_exercises/exercise_card.dart';
import 'package:client/components/shared/listview_editor.dart';
import 'package:client/utils/app_error.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/utils/app_router.dart';
import 'package:client/services/exercise_service.dart';
import 'package:client/utils/constants.dart';
import 'package:client/view_models/browse_exercises_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExercisesEditor extends StatelessWidget {
  final List<Exercise> exercises;

  ExercisesEditor({this.exercises});

  @override
  Widget build(BuildContext context) {
    BrowseExercisesModel model =
        Provider.of<BrowseExercisesModel>(context, listen: false);

    return StreamBuilder<bool>(
      initialData: false,
      stream: model.isEditing,
      builder: (context, snapshot) {
        bool isEditing = snapshot.data;

        return ListViewEditor(
          isEditing: isEditing,
          title: 'Choose Exercises',
          elevationColor: Constants.firstElevation,
          onAdd: () => Navigator.pushNamed(
            context,
            AppRouter.manageExercise,
          ),
          onEdit: () => model.setEditing(!isEditing),
          listView: ListView.builder(
            padding: const EdgeInsets.all(0.0),
            itemCount: exercises.length,
            itemBuilder: (BuildContext context, int index) {
              Exercise currentExercise = exercises[index];

              return ExerciseCard(
                exercise: currentExercise,
                onPressed: (bool selected) => {
                  if (!isEditing)
                    {
                      if (selected)
                        {
                          model.addExercise(currentExercise),
                        }
                      else
                        {
                          model.removeExercise(currentExercise),
                        }
                    }
                  else
                    {
                      Navigator.pushNamed(
                        context,
                        AppRouter.manageExercise,
                        arguments: currentExercise,
                      )
                    }
                },
                onRemovePressed: () => {
                  model.removeExercise(currentExercise),
                  _removeExercise(context, currentExercise.id),
                },
                isEditing: isEditing,
              );
            },
          ),
        );
      },
    );
  }

  void _removeExercise(BuildContext context, String exerciseId) {
    ExerciseService exerciseService =
        Provider.of<ExerciseService>(context, listen: false);

    try {
      exerciseService.removeExercise(exerciseId);
    } catch (e) {
      AppError.show(context, e.message);
    }
  }
}
