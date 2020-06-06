import 'package:client/auth_builder.dart';
import 'package:client/models/user.dart';
import 'package:client/pages/home_page.dart';
import 'package:client/pages/unknown_page.dart';
import 'package:client/pages/welcome_page.dart';
import 'package:client/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(SimpleFit());
}

class SimpleFit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (context) => AuthService(),
        )
      ],
      child: AuthBuilder(
        builder: (BuildContext context, AsyncSnapshot<User> userSnapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: _buildHome(userSnapshot),
            onGenerateRoute: (RouteSettings settings) {
              return MaterialPageRoute(
                settings: settings,
                builder: (BuildContext context) {
                  switch (settings.name) {
                    case HomePage.pageRoute:
                      return HomePage();
                    case WelcomePage.pageRoute:
                      return WelcomePage();
                    default:
                      return UnknownPage();
                  }
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHome(AsyncSnapshot<User> userSnapshot) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? HomePage() : WelcomePage();
    } else {
      return CircularProgressIndicator();
    }
  }
}
