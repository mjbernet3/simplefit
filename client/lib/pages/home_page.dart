import 'package:client/components/home/workout_card.dart';
import 'package:client/models/user_data.dart';
import 'package:client/models/workout_preview.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileService _profileService =
        Provider.of<ProfileService>(context, listen: false);
    AuthService _authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Workouts',
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () async => await _authService.signOut(),
                  ),
                ],
              ),
              StreamBuilder<UserData>(
                stream: _profileService.userData,
                builder:
                    (BuildContext context, AsyncSnapshot<UserData> snapshot) {
                  if (snapshot.hasData) {
                    final List<WorkoutPreview> _workouts =
                        snapshot.data.workouts;

                    return Expanded(
                      child: ReorderableListView(
                        children: _workouts
                            .map((workout) =>
                                WorkoutCard(workoutPreview: workout))
                            .toList(),
                        onReorder: (int oldIndex, int newIndex) {},
                      ),
                    );
                  }

                  // TODO: Decide whether to use loading indicator here
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
