import 'package:client/components/browse_exercises/exercise_card.dart';
import 'package:client/utils/app_error.dart';
import 'package:client/utils/app_style.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/utils/app_router.dart';
import 'package:client/services/exercise_service.dart';
import 'package:client/view_models/browse_exercises_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciseListing extends StatefulWidget {
  final List<Exercise> exercises;

  ExerciseListing({this.exercises});

  @override
  _ExerciseListingState createState() => _ExerciseListingState();
}

class _ExerciseListingState extends State<ExerciseListing> {
  IconData listIcon = Icons.edit;
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Choose exercises',
                  style: TextStyle(
                    color: AppStyle.highEmphasisText,
                    fontSize: 18.0,
                  ),
                ),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => setState(() => {
                            if (isEditing)
                              {
                                listIcon = Icons.edit,
                              }
                            else
                              {
                                listIcon = Icons.check,
                              },
                            isEditing = !isEditing
                          }),
                      child: Container(
                        height: 24.0,
                        width: 24.0,
                        child: Icon(
                          listIcon,
                          color: AppStyle.highEmphasisText,
                          size: 20.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    !isEditing
                        ? GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRouter.manageExercise,
                            ),
                            child: Icon(
                              Icons.add,
                              color: AppStyle.highEmphasisText,
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
          AppDivider(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: widget.exercises.length,
              itemBuilder: (BuildContext context, int index) {
                BrowseExercisesModel browseModel =
                    Provider.of<BrowseExercisesModel>(context, listen: false);
                return ExerciseCard(
                  exercise: widget.exercises[index],
                  onPressed: isEditing
                      ? (Exercise exercise, _) => Navigator.pushNamed(
                            context,
                            AppRouter.manageExercise,
                            arguments: exercise,
                          )
                      : (Exercise exercise, bool selected) {
                          if (selected) {
                            browseModel.addExercise(exercise);
                          } else {
                            browseModel.removeExercise(exercise);
                          }
                        },
                  onRemovePressed: (String exerciseId) =>
                      _removeExercise(exerciseId),
                  isEditing: isEditing,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _removeExercise(String exerciseId) async {
    ExerciseService _exerciseService =
        Provider.of<ExerciseService>(context, listen: false);

    try {
      await _exerciseService.removeExercise(exerciseId);
    } catch (e) {
      AppError.show(context, e.message);
    }
  }
}
