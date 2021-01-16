import 'package:client/components/home/preview_card.dart';
import 'package:client/models/user/user_data.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/models/workout/workout_preview.dart';
import 'package:client/services/profile_service.dart';
import 'package:client/services/workout_service.dart';
import 'package:client/utils/app_error.dart';
import 'package:client/utils/app_router.dart';
import 'package:client/view_models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreviewListing extends StatelessWidget {
  final bool isEditing;

  PreviewListing({this.isEditing});

  @override
  Widget build(BuildContext context) {
    ProfileService _profileService =
        Provider.of<ProfileService>(context, listen: false);

    return StreamBuilder<UserData>(
      stream: _profileService.userData,
      builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
        if (snapshot.hasData) {
          List<WorkoutPreview> _previews = snapshot.data.workouts;

          return ListView.builder(
            itemCount: _previews.length,
            itemBuilder: (BuildContext context, int index) {
              WorkoutPreview _currentPreview = _previews[index];

              return PreviewCard(
                key: ObjectKey(_currentPreview),
                isEditing: isEditing,
                onPressed: () => {
                  if (!isEditing)
                    {
                      _startWorkout(context, _currentPreview),
                    }
                  else
                    {
                      _editWorkout(context, _currentPreview),
                    }
                },
                onRemovePressed: () => _removeWorkout(context, _currentPreview),
                workoutPreview: _currentPreview,
              );
            },
          );
        }

        return Container();
      },
    );
  }

  void _startWorkout(BuildContext context, WorkoutPreview preview) async {
    HomeModel _model = Provider.of<HomeModel>(context, listen: false);

    try {
      Workout _workout = await _model.getWorkout(preview.id);

      Navigator.pushNamed(
        context,
        AppRouter.startWorkout,
        arguments: _workout,
      );
    } catch (e) {
      AppError.show(context, e.message);
    }
  }

  void _editWorkout(BuildContext context, WorkoutPreview preview) async {
    HomeModel _model = Provider.of<HomeModel>(context, listen: false);

    try {
      Workout _workout = await _model.getWorkout(preview.id);

      Navigator.pushNamed(
        context,
        AppRouter.manageWorkout,
        arguments: _workout,
      );
    } catch (e) {
      AppError.show(context, e.message);
    }
  }

  void _removeWorkout(BuildContext context, WorkoutPreview preview) async {
    WorkoutService _workoutService =
        Provider.of<WorkoutService>(context, listen: false);

    try {
      await _workoutService.removeWorkout(preview);
    } catch (e) {
      AppError.show(context, e.message);
    }
  }
}
