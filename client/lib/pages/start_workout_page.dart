import 'package:client/models/workout/workout.dart';
import 'package:flutter/material.dart';

class StartWorkoutPage extends StatelessWidget {
  final Workout workout;

  const StartWorkoutPage({this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(workout.name),
      ),
    );
  }
}
