import 'package:client/app_style.dart';
import 'package:client/components/home/workout_card.dart';
import 'package:client/models/user/user_data.dart';
import 'package:client/models/workout/workout_preview.dart';
import 'package:client/router.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum PopupChoice {
  ADD,
  EDIT,
  SETTINGS,
}

class HomePage extends StatelessWidget {
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
            onSelected: (value) => _handleChoice(value, context),
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
                      .map((workout) => WorkoutCard(workoutPreview: workout))
                      .toList(),
                  onReorder: (int oldIndex, int newIndex) {},
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
        AuthService authService =
            Provider.of<AuthService>(context, listen: false);
        authService.signOut();
        break;
      case PopupChoice.SETTINGS:
        Navigator.pushNamed(context, Router.settings);
        break;
    }
  }
}
