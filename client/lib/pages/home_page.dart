import 'package:client/components/home/preview_listing.dart';
import 'package:client/components/shared/app_bar_loading_indicator.dart';
import 'package:client/components/shared/app_icon_button.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/utils/constants.dart';
import 'package:client/utils/app_router.dart';
import 'package:client/utils/page_builder.dart';
import 'package:client/view_models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum PopupChoice {
  ADD,
  EDIT,
  SIGNOUT,
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeModel model = Provider.of<HomeModel>(context, listen: false);

    return StreamBuilder<bool>(
      initialData: false,
      stream: model.isEditing,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        bool isEditing = snapshot.data;

        return PageBuilder(
          appBar: AppBar(
            backgroundColor: Constants.firstElevation,
            elevation: 4.0,
            centerTitle: false,
            title: const Text(
              'My Workouts',
              style: TextStyle(fontSize: 20.0),
            ),
            actions: [
              !isEditing
                  ? PopupMenuButton<PopupChoice>(
                      icon: const Icon(Icons.more_vert),
                      color: Constants.secondElevation,
                      onSelected: (PopupChoice choice) =>
                          _handleChoice(choice, context),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<PopupChoice>>[
                        const PopupMenuItem<PopupChoice>(
                          value: PopupChoice.ADD,
                          child: Text('Add Workout'),
                        ),
                        const PopupMenuItem<PopupChoice>(
                          value: PopupChoice.EDIT,
                          child: Text('Edit Workout'),
                        ),
                        const PopupMenuItem<PopupChoice>(
                          value: PopupChoice.SIGNOUT,
                          child: Text('Sign Out'),
                        ),
                      ],
                    )
                  : AppIconButton(
                      icon: const Icon(
                        Icons.check,
                        size: 22.0,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      elevation: 0.0,
                      onPressed: () => model.setEditing(false),
                    ),
            ],
            bottom: AppBarLoadingIndicator(isLoading: model.isLoading),
          ),
          body: (BuildContext context) {
            return PreviewListing(isEditing: isEditing);
          },
        );
      },
    );
  }

  void _handleChoice(PopupChoice choice, BuildContext context) {
    switch (choice) {
      case PopupChoice.ADD:
        Navigator.pushNamed(context, AppRouter.manageWorkout);
        break;
      case PopupChoice.EDIT:
        HomeModel model = Provider.of<HomeModel>(context, listen: false);
        model.setEditing(true);
        break;
      case PopupChoice.SIGNOUT:
        AuthService authService =
            Provider.of<AuthService>(context, listen: false);
        authService.signOut();
        break;
    }
  }
}
