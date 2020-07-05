import 'package:client/app_style.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/exercise_card.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/services/exercise_service.dart';
import 'package:client/utils/structures/response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciseListing extends StatefulWidget {
  @override
  _ExerciseListingState createState() => _ExerciseListingState();
}

class _ExerciseListingState extends State<ExerciseListing> {
  IconData listIcon = Icons.edit;
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    ExerciseService _exerciseService =
        Provider.of<ExerciseService>(context, listen: false);
    return StreamBuilder<List<Exercise>>(
      stream: _exerciseService.exercises,
      builder: (BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Expanded(
              child: Center(
                child: Text(
                  'You have no exercises.',
                  style: TextStyle(
                    color: AppStyle.medEmphasisText,
                  ),
                ),
              ),
            );
          }

          final List<Exercise> exercises = snapshot.data;

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
                        'My Exercises',
                        style: TextStyle(
                          color: AppStyle.highEmphasisText,
                          fontSize: 18.0,
                        ),
                      ),
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
                        child: Icon(
                          listIcon,
                          color: AppStyle.highEmphasisText,
                          size: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
                AppDivider(),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(0.0),
                    itemCount: exercises.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ExerciseCard(
                        exercise: exercises[index],
                        onPressed: () => print('hello'),
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

        return Container();
      },
    );
  }

  void _removeExercise(String exerciseId) async {
    ExerciseService _exerciseService =
        Provider.of<ExerciseService>(context, listen: false);

    Response response = await _exerciseService.removeExercise(exerciseId);

    if (response.status == Status.FAILURE) {
      // TODO: Handle backend error
    }
  }
}
