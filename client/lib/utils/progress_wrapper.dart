import 'package:client/services/workout_service.dart';
import 'package:client/view_models/progress_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgressWrapper extends StatelessWidget {
  final Widget child;

  const ProgressWrapper({this.child});

  @override
  Widget build(BuildContext context) {
    return Provider<ProgressModel>(
      create: (context) => ProgressModel(
        workoutService: Provider.of<WorkoutService>(
          context,
          listen: false,
        ),
      ),
      dispose: (context, model) => model.dispose(),
      child: child,
    );
  }
}
