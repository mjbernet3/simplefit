import 'package:client/models/user/user.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/services/exercise_service.dart';
import 'package:client/services/profile_service.dart';
import 'package:client/services/workout_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, AsyncSnapshot<User> userSnapshot)
      builder;

  AuthBuilder({
    Key key,
    this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _authService =
        Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<User>(
      stream: _authService.signedInUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final User _user = snapshot.data;

          return MultiProvider(
            providers: [
              Provider<WorkoutService>(
                create: (context) => WorkoutService(_user.uid),
              ),
              Provider<ExerciseService>(
                create: (context) => ExerciseService(_user.uid),
              ),
              Provider<ProfileService>(
                create: (context) => ProfileService(_user.uid),
              ),
            ],
            child: builder(context, snapshot),
          );
        }

        return builder(context, snapshot);
      },
    );
  }
}
