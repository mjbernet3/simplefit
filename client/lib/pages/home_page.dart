import 'package:client/app_style.dart';
import 'package:client/components/home/workout_card.dart';
import 'package:client/models/user/user_data.dart';
import 'package:client/models/workout/workout_preview.dart';
import 'package:client/router.dart';
import 'package:client/services/profile_service.dart';
import 'package:client/services/workout_service.dart';
import 'package:client/utils/structures/response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum PopupChoice {
  ADD,
  EDIT,
  SETTINGS,
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    ProfileService _profileService =
        Provider.of<ProfileService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppStyle.dp2,
        title: Text(
          'My Workouts',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        actions: <Widget>[
          PopupMenuButton<PopupChoice>(
            icon: Icon(Icons.more_vert),
            color: AppStyle.dp2,
            onSelected: (PopupChoice value) => _handleChoice(value, context),
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<PopupChoice>>[
              PopupMenuItem<PopupChoice>(
                value: PopupChoice.ADD,
                child: Text('Add Workout'),
              ),
              PopupMenuItem<PopupChoice>(
                value: PopupChoice.EDIT,
                child: Text('Edit Workout'),
              ),
              PopupMenuItem<PopupChoice>(
                value: PopupChoice.SETTINGS,
                child: Text('Settings'),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: StreamBuilder<UserData>(
            stream: _profileService.userData,
            builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
              if (snapshot.hasData) {
                final List<WorkoutPreview> _workouts = snapshot.data.workouts;

                return ReorderableListView(
                  children: _workouts
                      .map(
                        (workout) => WorkoutCard(
                          key: ObjectKey(workout),
                          isEditing: isEditing,
                          onPressed: () => {
                            if (!isEditing)
                              {
                                // Go start the workout
                              }
                            else
                              {
                                // Go edit the workout
                              }
                          },
                          onRemovePressed: () => _removeWorkout(workout),
                          workoutPreview: workout,
                        ),
                      )
                      .toList(),
                  onReorder: (int oldIndex, int newIndex) {
                    print(oldIndex);
                    print(newIndex);
                  },
                );
              }

              // TODO: Decide whether to use loading indicator here
              return Container();
            },
          ),
        ),
      ),
    );
  }

  void _handleChoice(PopupChoice choice, BuildContext context) {
    switch (choice) {
      case PopupChoice.ADD:
        Navigator.pushNamed(context, Router.createWorkout);
        break;
      case PopupChoice.EDIT:
        setState(() => isEditing = !isEditing);
        break;
      case PopupChoice.SETTINGS:
        Navigator.pushNamed(context, Router.settings);
        break;
    }
  }

  void _removeWorkout(WorkoutPreview workout) async {
    WorkoutService workoutService =
        Provider.of<WorkoutService>(context, listen: false);

    Response response = await workoutService.removeWorkout(workout.id);

    if (response.status == Status.FAILURE) {
      //TODO: Show backend error
    }
  }
}
