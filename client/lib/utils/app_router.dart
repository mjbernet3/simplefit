import 'package:client/pages/perform_exercise_page.dart';
import 'package:client/utils/app_style.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/pages/exercise_browse_page.dart';
import 'package:client/pages/exercise_detail_page.dart';
import 'package:client/pages/manage_exercise_page.dart';
import 'package:client/components/shared/simple_popup.dart';
import 'package:client/pages/manage_workout_page.dart';
import 'package:client/pages/home_page.dart';
import 'package:client/pages/login_page.dart';
import 'package:client/pages/notes_page.dart';
import 'package:client/pages/register_page.dart';
import 'package:client/pages/settings_page.dart';
import 'package:client/pages/start_workout_page.dart';
import 'package:client/pages/unknown_page.dart';
import 'package:client/pages/welcome_page.dart';
import 'package:client/view_models/exercise_browse_model.dart';
import 'package:client/view_models/manage_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppRouter {
  AppRouter._();

  static const String home = '/';
  static const String welcome = '/welcome';
  static const String register = '/register';
  static const String login = '/login';
  static const String manageWorkout = '/workouts/manage';
  static const String startWorkout = '/workouts/start';
  static const String manageExercise = '/exercises/manage';
  static const String exerciseDetail = '/exercises/detail';
  static const String performExercise = '/exercises/perform';
  static const String notes = '/notes';
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
        return MaterialPageRoute(
          builder: (context) =>
              StartWorkoutPage(workout: routeSettings.arguments),
        );
      case exerciseDetail:
        return MaterialPageRoute<ExerciseData>(
          builder: (context) =>
              ExerciseDetailPage(exerciseData: routeSettings.arguments),
        );
      case performExercise:
        return MaterialPageRoute(builder: (context) => PerformExercisePage());
      case settings:
        return MaterialPageRoute(builder: (context) => SettingsPage());
      case notes:
        return SimplePopUp<String>(
          isAnimated: false,
          renderBox: routeSettings.arguments,
          builder: (context) => NotesPage(),
        );
      case browser:
        return SimplePopUp<List<Exercise>>(
          backgroundColor: AppStyle.backgroundColor.withOpacity(0.5),
          builder: (context) => Provider<ExerciseBrowseModel>(
            create: (context) => ExerciseBrowseModel(),
            dispose: (context, model) => model.dispose(),
            child: ExerciseBrowsePage(),
          ),
        );
      case manageExercise:
        return SimplePopUp(
          isAnimated: false,
          builder: (context) =>
              ManageExercisePage(exercise: routeSettings.arguments),
        );
      default:
        return MaterialPageRoute(builder: (context) => UnknownPage());
    }
  }
}
