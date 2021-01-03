import 'package:client/utils/app_router.dart';
import 'package:client/utils/app_style.dart';
import 'package:client/components/shared/notes_dropdown.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/components/start_workout/exercise_bullet_card.dart';
import 'package:client/models/workout/workout.dart';
import 'package:flutter/material.dart';

class StartWorkoutPage extends StatelessWidget {
  final Workout workout;

  const StartWorkoutPage({this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workout.name,
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
            NotesDropdown(),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: workout.exercises.length,
                itemBuilder: (BuildContext context, int index) {
                  return ExerciseBulletCard(
                    exerciseName: workout.exercises[index].exercise.name,
                  );
                },
              ),
            ),
            Center(
              child: RoundedButton(
                color: AppStyle.dp4,
                borderColor: AppStyle.primaryColor,
                buttonText: Text(
                  "Start Workout",
                  style: TextStyle(
                    color: AppStyle.highEmphasisText,
                  ),
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, AppRouter.performExercise),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
