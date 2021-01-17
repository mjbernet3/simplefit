import 'package:client/utils/app_router.dart';
import 'package:client/utils/constants.dart';
import 'package:client/components/shared/notes_dropdown.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/components/start_workout/exercise_bullet_card.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/utils/page_wrapper.dart';
import 'package:flutter/material.dart';

class StartWorkoutPage extends StatelessWidget {
  final Workout workout;

  StartWorkoutPage({this.workout});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            workout.name,
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(height: 10.0),
          NotesDropdown(
            notes: workout.notes,
            onComplete: (String newNotes) => workout.notes = newNotes,
          ),
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
              borderColor: Constants.primaryColor,
              buttonText: 'Start Workout',
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                AppRouter.performWorkout,
                arguments: workout,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
