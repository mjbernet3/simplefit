import 'package:client/pages/perform_exercise_page.dart';
import 'package:client/services/workout_service.dart';
import 'package:client/utils/app_style.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/pages/browse_exercises_page.dart';
import 'package:client/pages/detail_exercise_page.dart';
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
import 'package:client/utils/structures/route_arguments.dart';
import 'package:client/view_models/browse_exercises_model.dart';
import 'package:client/view_models/manage_workout_model.dart';
import 'package:client/view_models/progress_model.dart';
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
  static const String detailExercise = '/exercises/detail';
  static const String performExercise = '/exercises/perform';
  static const String browseExercises = '/exercises/browse';
  static const String notes = '/notes';
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
      case detailExercise:
        return MaterialPageRoute<ExerciseData>(
          builder: (context) =>
              DetailExercisePage(exerciseData: routeSettings.arguments),
        );
      case performExercise:
        return MaterialPageRoute(
          builder: (context) => Provider<ProgressModel>(
            create: (context) => ProgressModel(
              workoutService: Provider.of<WorkoutService>(
                context,
                listen: false,
              ),
              workout: routeSettings.arguments,
            ),
            dispose: (context, model) => model.dispose(),
            child: PerformExercisePage(),
          ),
        );
      case settings:
        return MaterialPageRoute(builder: (context) => SettingsPage());
      case notes:
        RouteArguments routeArgs = routeSettings.arguments;

        return SimplePopUp(
          isAnimated: false,
          renderBox: routeArgs.arguments["renderBox"],
          builder: (context) => NotesPage(
            messenger: routeArgs.arguments["messenger"],
          ),
        );
      case browseExercises:
        return SimplePopUp<List<Exercise>>(
          backgroundColor: AppStyle.backgroundColor.withOpacity(0.5),
          builder: (context) => Provider<BrowseExercisesModel>(
            create: (context) => BrowseExercisesModel(),
            dispose: (context, model) => model.dispose(),
            child: BrowseExercisesPage(),
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
