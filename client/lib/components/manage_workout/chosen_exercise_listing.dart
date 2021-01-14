import 'package:client/components/manage_workout/chosen_exercise_card.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/utils/app_router.dart';
import 'package:client/view_models/manage_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChosenExerciseListing extends StatefulWidget {
  @override
  _ChosenExerciseListingState createState() => _ChosenExerciseListingState();
}

class _ChosenExerciseListingState extends State<ChosenExerciseListing> {
  ManageWorkoutModel _model;
  bool _isEditing = false;
  IconData _listIcon = Icons.edit;

  @override
  void initState() {
    _model = Provider.of<ManageWorkoutModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ExerciseData>>(
      stream: _model.exerciseStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ExerciseData>> snapshot) {
        if (snapshot.hasData) {
          List<ExerciseData> exercises = snapshot.data;

          if (exercises.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Exercises',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Divider(),
                RoundedButton(
                  buttonText: 'Add Exercise',
                  height: 30.0,
                  onPressed: () => _browseExercises(context),
                ),
              ],
            );
          } else {
            return Column(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
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
                            onTap: () => setState(
                              () => {
                                if (_isEditing)
                                  {
                                    _listIcon = Icons.edit,
                                  }
                                else
                                  {
                                    _listIcon = Icons.check,
                                  },
                                _isEditing = !_isEditing
                              },
                            ),
                            child: Container(
                              height: 24.0,
                              width: 24.0,
                              child: Icon(
                                _listIcon,
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
                            onPressed: () =>
                                _detailExercise(index, currentExercise),
                            onRemovePressed: () =>
                                _model.removeExerciseAt(index),
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
        }

        return Container();
      },
    );
  }

  void _browseExercises(BuildContext context) async {
    List<Exercise> chosenExercises =
        await Navigator.pushNamed(context, AppRouter.browseExercises);

    if (chosenExercises != null) {
      _model.initExercises(chosenExercises);
    }
  }

  void _detailExercise(int index, ExerciseData exercise) async {
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
