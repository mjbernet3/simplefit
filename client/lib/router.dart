import 'package:client/pages/home_page.dart';
import 'package:client/pages/login_page.dart';
import 'package:client/pages/register_page.dart';
import 'package:client/pages/unknown_page.dart';
import 'package:client/pages/welcome_page.dart';
import 'package:flutter/material.dart';

class Router {
  Router._();

  static const String home = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) {
        switch (settings.name) {
          case home:
            return HomePage();
          case welcome:
            return WelcomePage();
          case register:
            return RegisterPage();
          case login:
            return LoginPage();
          default:
            return UnknownPage();
        }
      },
    );
  }
}
