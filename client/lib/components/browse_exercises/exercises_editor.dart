import 'package:client/components/browse_exercises/exercise_card.dart';
import 'package:client/utils/app_error.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/utils/app_router.dart';
import 'package:client/services/exercise_service.dart';
import 'package:client/view_models/browse_exercises_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExercisesEditor extends StatelessWidget {
  final List<Exercise> exercises;

  ExercisesEditor({this.exercises});

  @override
  Widget build(BuildContext context) {
    BrowseExercisesModel _model =
        Provider.of<BrowseExercisesModel>(context, listen: false);

    return StreamBuilder<bool>(
      initialData: false,
      stream: _model.isEditing,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        bool _isEditing = snapshot.data;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Choose exercises',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => _model.setEditing(!_isEditing),
                        child: Container(
                          height: 24.0,
                          width: 24.0,
                          child: Icon(
                            _isEditing ? Icons.check : Icons.edit,
                            size: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      !_isEditing
                          ? GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                AppRouter.manageExercise,
                              ),
                              child: Icon(Icons.add),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(0.0),
                itemCount: exercises.length,
                itemBuilder: (BuildContext context, int index) {
                  Exercise _currentExercise = exercises[index];

                  return ExerciseCard(
                    exercise: _currentExercise,
                    onPressed: (bool selected) => {
                      if (!_isEditing)
                        {
                          if (selected)
                            {
                              _model.addExercise(_currentExercise),
                            }
                          else
                            {
                              _model.removeExercise(_currentExercise),
                            }
                        }
                      else
                        {
                          Navigator.pushNamed(
                            context,
                            AppRouter.manageExercise,
                            arguments: _currentExercise,
                          )
                        }
                    },
                    onRemovePressed: () => {
                      _model.removeExercise(_currentExercise),
                      _removeExercise(context, _currentExercise.id),
                    },
                    isEditing: _isEditing,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _removeExercise(BuildContext context, String exerciseId) async {
    ExerciseService _exerciseService =
        Provider.of<ExerciseService>(context, listen: false);

    try {
      await _exerciseService.removeExercise(exerciseId);
    } catch (e) {
      AppError.show(context, e.message);
    }
  }
}
