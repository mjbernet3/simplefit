import 'package:client/components/home/preview_card.dart';
import 'package:client/models/user/user_data.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/models/workout/workout_preview.dart';
import 'package:client/services/profile_service.dart';
import 'package:client/services/workout_service.dart';
import 'package:client/utils/app_error.dart';
import 'package:client/utils/app_router.dart';
import 'package:client/utils/constants.dart';
import 'package:client/view_models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreviewListing extends StatelessWidget {
  final bool isEditing;

  PreviewListing({this.isEditing});

  @override
  Widget build(BuildContext context) {
    ProfileService profileService =
        Provider.of<ProfileService>(context, listen: false);

    return StreamBuilder<UserData>(
      stream: profileService.userData,
      builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
        if (snapshot.hasData) {
          List<WorkoutPreview> previews = snapshot.data.previews;

          if (previews.isEmpty) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Tap the ',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Constants.medEmphasis,
                    ),
                  ),
                  const Icon(Icons.more_vert),
                  const Text(
                    ' icon to get started',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Constants.medEmphasis,
                    ),
                  ),
                ],
              ),
            );
          }

          return isEditing
              ? ReorderableListView(
                  children: previews
                      .map(
                        (preview) => PreviewCard(
                          key: ObjectKey(preview),
                          isEditing: isEditing,
                          onPressed: () => _editWorkout(context, preview),
                          onRemovePressed: () =>
                              _removeWorkout(context, preview),
                          workoutPreview: preview,
                        ),
                      )
                      .toList(),
                  onReorder: (int oldIndex, int newIndex) =>
                      _reorderPreviews(context, previews, oldIndex, newIndex),
                )
              : ListView.builder(
                  itemCount: previews.length,
                  itemBuilder: (BuildContext context, int index) {
                    WorkoutPreview currentPreview = previews[index];

                    return PreviewCard(
                      key: ObjectKey(currentPreview),
                      isEditing: isEditing,
                      onPressed: () => _startWorkout(context, currentPreview),
                      workoutPreview: currentPreview,
                    );
                  },
                );
        }

        return const SizedBox.shrink();
      },
    );
  }

  void _startWorkout(BuildContext context, WorkoutPreview preview) async {
    HomeModel model = Provider.of<HomeModel>(context, listen: false);

    try {
      Workout workout = await model.getWorkout(preview.id);

      Navigator.pushNamed(
        context,
        AppRouter.startWorkout,
        arguments: workout,
      );
    } catch (e) {
      AppError.show(context, e.message);
    }
  }

  void _editWorkout(BuildContext context, WorkoutPreview preview) async {
    HomeModel model = Provider.of<HomeModel>(context, listen: false);

    try {
      Workout workout = await model.getWorkout(preview.id);

      Navigator.pushNamed(
        context,
        AppRouter.manageWorkout,
        arguments: workout,
      );
    } catch (e) {
      AppError.show(context, e.message);
    }
  }

  void _reorderPreviews(BuildContext context, List<WorkoutPreview> previews,
      int oldIndex, int newIndex) {
    ProfileService profileService =
        Provider.of<ProfileService>(context, listen: false);

    if (oldIndex < newIndex) {
      newIndex--;
    }

    WorkoutPreview preview = previews.removeAt(oldIndex);
    previews.insert(newIndex, preview);

    try {
      profileService.reorderPreviews(previews);
    } catch (e) {
      AppError.show(context, e.message);
    }
  }

  void _removeWorkout(BuildContext context, WorkoutPreview preview) async {
    WorkoutService workoutService =
        Provider.of<WorkoutService>(context, listen: false);

    try {
      workoutService.removeWorkout(preview);
    } catch (e) {
      AppError.show(context, e.message);
    }
  }
}
