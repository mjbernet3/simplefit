import 'package:client/components/manage_workout/chosen_exercise_card.dart';
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
    ManageWorkoutModel _model =
        Provider.of<ManageWorkoutModel>(context, listen: false);

    return StreamBuilder<bool>(
      stream: _model.isEditing,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          bool _isEditing = snapshot.data;

          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Exercises',
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
                                onTap: () => _browseExercises(context),
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
                child: ListView(
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
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
                          onRemovePressed: () => _model.removeExerciseAt(index),
                          isEditing: _isEditing,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return Container();
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
      BuildContext context, int index, ExerciseData exercise) async {
    ManageWorkoutModel _model =
        Provider.of<ManageWorkoutModel>(context, listen: false);

    ExerciseData newExerciseData = await Navigator.pushNamed(
      context,
      AppRouter.detailExercise,
      arguments: exercise.copy(),
    );

    if (newExerciseData != null) {
      _model.updateExerciseAt(index, newExerciseData);
    }
  }
}
