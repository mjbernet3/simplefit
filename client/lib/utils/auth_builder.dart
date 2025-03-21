import 'package:client/models/user/app_user.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/services/exercise_service.dart';
import 'package:client/services/profile_service.dart';
import 'package:client/services/workout_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, AsyncSnapshot<AppUser?> snapshot)
      builder;

  AuthBuilder({required this.builder});

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context, listen: false);

    return StreamBuilder<AppUser?>(
      stream: authService.signedInUser,
      builder: (BuildContext context, AsyncSnapshot<AppUser?> snapshot) {
        if (snapshot.hasData) {
          AppUser user = snapshot.data!;

          return MultiProvider(
            providers: [
              Provider<WorkoutService>(
                create: (context) => WorkoutService(user.uid),
              ),
              Provider<ExerciseService>(
                create: (context) => ExerciseService(user.uid),
              ),
              Provider<ProfileService>(
                create: (context) => ProfileService(user.uid),
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
