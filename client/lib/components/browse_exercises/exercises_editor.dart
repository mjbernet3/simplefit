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
  final List<Exercise> chosenExercises;

  ExercisesEditor({
    required this.exercises,
    required this.chosenExercises,
  });

  @override
  Widget build(BuildContext context) {
    BrowseExercisesModel model =
        Provider.of<BrowseExercisesModel>(context, listen: false);

    return StreamBuilder<bool>(
      initialData: false,
      stream: model.isEditing,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        bool isEditing = snapshot.data!;

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
                  if (currentExercise.id != null) {
                    _removeExercise(context, currentExercise.id!)
                  }
                },
                isEditing: isEditing,
                isSelected: chosenExercises.any(
                        (exercise) => currentExercise.equals(exercise)),
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

    // TODO: Improve error handling
    try {
      exerciseService.removeExercise(exerciseId);
    } catch (e) {
      AppError.show(context, e.toString());
    }
  }
}
