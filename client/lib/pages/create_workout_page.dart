import 'package:client/components/create_workout/create_workout_body.dart';
import 'package:flutter/material.dart';

class CreateWorkoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Workout',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: CreateWorkoutBody(),
      ),
    );
  }
}
