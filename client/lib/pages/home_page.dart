import 'package:client/utils/app_style.dart';
import 'package:client/components/home/workout_card.dart';
import 'package:client/models/user/user_data.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/models/workout/workout_preview.dart';
import 'package:client/utils/app_router.dart';
import 'package:client/services/profile_service.dart';
import 'package:client/services/workout_service.dart';
import 'package:client/utils/structures/response.dart';
import 'package:client/view_models/progress_model.dart';
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
          !isEditing
              ? PopupMenuButton<PopupChoice>(
                  icon: Icon(Icons.more_vert),
                  color: AppStyle.dp2,
                  onSelected: (PopupChoice value) =>
                      _handleChoice(value, context),
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
                )
              : Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                  child: GestureDetector(
                    onTap: () => setState(() => isEditing = !isEditing),
                    child: Container(
                      height: 24.0,
                      width: 24.0,
                      child: Icon(
                        Icons.check,
                        color: AppStyle.highEmphasisText,
                        size: 20.0,
                      ),
                    ),
                  ),
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
                List<WorkoutPreview> _workouts = snapshot.data.workouts;

                return ListView.builder(
                  itemCount: _workouts.length,
                  itemBuilder: (BuildContext context, int index) {
                    WorkoutPreview _currentWorkout = _workouts[index];

                    return WorkoutCard(
                      key: ObjectKey(_currentWorkout),
                      isEditing: isEditing,
                      onPressed: () => {
                        if (!isEditing)
                          {
                            _startWorkout(_currentWorkout),
                          }
                        else
                          {
                            Navigator.pushNamed(
                              context,
                              AppRouter.manageWorkout,
                              arguments: _currentWorkout,
                            ),
                          }
                      },
                      onRemovePressed: () => _removeWorkout(_currentWorkout),
                      workoutPreview: _currentWorkout,
                    );
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
        Navigator.pushNamed(context, AppRouter.manageWorkout);
        break;
      case PopupChoice.EDIT:
        setState(() => isEditing = !isEditing);
        break;
      case PopupChoice.SETTINGS:
        Navigator.pushNamed(context, AppRouter.settings);
        break;
    }
  }

  void _startWorkout(WorkoutPreview preview) async {
    ProgressModel model = Provider.of<ProgressModel>(context, listen: false);

    Response response = await model.initWorkout(preview.id);

    if (response.status == Status.FAILURE) {
      print(response.message);
      //TODO: Show backend error
    } else {
      Workout workout = response.data;

      Navigator.pushNamed(context, AppRouter.startWorkout, arguments: workout);
    }
  }

  void _removeWorkout(WorkoutPreview preview) async {
    WorkoutService workoutService =
        Provider.of<WorkoutService>(context, listen: false);

    Response response = await workoutService.removeWorkout(preview);

    if (response.status == Status.FAILURE) {
      //TODO: Show backend error
    }
  }
}
