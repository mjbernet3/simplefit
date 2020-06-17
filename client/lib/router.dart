import 'package:client/pages/create_workout_page.dart';
import 'package:client/pages/home_page.dart';
import 'package:client/pages/login_page.dart';
import 'package:client/pages/register_page.dart';
import 'package:client/pages/settings_page.dart';
import 'package:client/pages/unknown_page.dart';
import 'package:client/pages/welcome_page.dart';
import 'package:flutter/material.dart';

class Router {
  Router._();

  static const String home = '/';
  static const String welcome = '/welcome';
  static const String register = '/register';
  static const String login = '/login';
  static const String createWorkout = '/create';
  static const String settings = '/settings';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          case home:
            return HomePage();
          case welcome:
            return WelcomePage();
          case register:
            return RegisterPage();
          case login:
            return LoginPage();
          case createWorkout:
            return CreateWorkoutPage();
          case settings:
            return SettingsPage();
          default:
            return UnknownPage();
        }
      },
    );
  }
}
