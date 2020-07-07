import 'package:client/components/manage_workout/manage_workout_body.dart';
import 'package:flutter/material.dart';

class ManageWorkoutPage extends StatelessWidget {
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
        child: ManageWorkoutBody(),
      ),
    );
  }
}
