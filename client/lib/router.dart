import 'package:client/app_style.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/pages/exercise_browse_page.dart';
import 'package:client/pages/exercise_detail_page.dart';
import 'package:client/pages/manage_exercise_page.dart';
import 'package:client/components/shared/large_popup.dart';
import 'package:client/pages/manage_workout_page.dart';
import 'package:client/pages/home_page.dart';
import 'package:client/pages/login_page.dart';
import 'package:client/pages/register_page.dart';
import 'package:client/pages/settings_page.dart';
import 'package:client/pages/start_workout_page.dart';
import 'package:client/pages/unknown_page.dart';
import 'package:client/pages/welcome_page.dart';
import 'package:client/view_models/exercise_browse_model.dart';
import 'package:client/view_models/manage_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Router {
  Router._();

  static const String home = '/';
  static const String welcome = '/welcome';
  static const String register = '/register';
  static const String login = '/login';
  static const String manageWorkout = '/workouts/manage';
  static const String startWorkout = '/workouts/start';
  static const String manageExercise = '/exercises/manage';
  static const String exerciseDetail = '/exercises/detail';
  static const String browser = '/browser';
  static const String settings = '/settings';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => HomePage());
      case welcome:
        return MaterialPageRoute(builder: (context) => WelcomePage());
      case register:
        return MaterialPageRoute(builder: (context) => RegisterPage());
      case login:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case manageWorkout:
        return MaterialPageRoute(
          builder: (context) => Provider<ManageWorkoutModel>(
            create: (context) => ManageWorkoutModel(),
            dispose: (context, model) => model.dispose(),
            child: ManageWorkoutPage(preview: routeSettings.arguments),
          ),
        );
      case startWorkout:
        return MaterialPageRoute(builder: (context) => StartWorkoutPage());
      case exerciseDetail:
        return MaterialPageRoute<ExerciseData>(
          builder: (context) =>
              ExerciseDetailPage(exerciseData: routeSettings.arguments),
        );
      case settings:
        return MaterialPageRoute(builder: (context) => SettingsPage());
      case browser:
        return LargePopUp<List<Exercise>>(
          backgroundColor: AppStyle.backgroundColor.withOpacity(0.5),
          builder: (context) => Provider<ExerciseBrowseModel>(
            create: (context) => ExerciseBrowseModel(),
            dispose: (context, model) => model.dispose(),
            child: ExerciseBrowsePage(),
          ),
        );
      case manageExercise:
        return LargePopUp(
          animationLength: 0,
          builder: (context) =>
              ManageExercisePage(exercise: routeSettings.arguments),
        );
      default:
        return MaterialPageRoute(builder: (context) => UnknownPage());
    }
  }
}
