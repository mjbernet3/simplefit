import 'package:client/models/user/app_user.dart';
import 'package:client/services/workout_service.dart';
import 'package:client/utils/app_theme.dart';
import 'package:client/utils/auth_builder.dart';
import 'package:client/pages/home_page.dart';
import 'package:client/pages/welcome_page.dart';
import 'package:client/utils/app_router.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/view_models/home_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(SimpleFit());
}

class SimpleFit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: Firebase.initializeApp(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Provider<AuthService>(
            create: (context) => AuthService(),
            child: AuthBuilder(
              builder: (BuildContext context, AsyncSnapshot<AppUser?> snapshot) {
                return GestureDetector(
                  onTap: () => _closeKeyboard(context),
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: _buildHome(context, snapshot),
                    theme: AppTheme(context).darkTheme,
                    onGenerateRoute: AppRouter.generateRoute,
                  ),
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildHome(BuildContext context, AsyncSnapshot<AppUser?> snapshot) {
    if (snapshot.connectionState == ConnectionState.active) {
      bool isUser = snapshot.hasData;

      return isUser
          ? Provider<HomeModel>(
              create: (context) => HomeModel(
                workoutService: Provider.of<WorkoutService>(
                  context,
                  listen: false,
                ),
              ),
              dispose: (context, model) => model.dispose(),
              child: HomePage(),
            )
          : WelcomePage();
    } else {
      return Container();
    }
  }

  void _closeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
