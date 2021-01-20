import 'package:client/components/home/preview_listing.dart';
import 'package:client/components/shared/app_bar_loading_indicator.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/utils/constants.dart';
import 'package:client/utils/app_router.dart';
import 'package:client/components/shared/page_builder.dart';
import 'package:client/view_models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum PopupChoice {
  ADD,
  EDIT,
  SETTINGS,
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeModel _model = Provider.of<HomeModel>(context, listen: false);

    return StreamBuilder<bool>(
      initialData: false,
      stream: _model.isEditing,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        bool _isEditing = snapshot.data;

        return PageBuilder(
          appBar: AppBar(
            backgroundColor: Constants.firstElevation,
            elevation: 4.0,
            centerTitle: false,
            title: Text(
              'My Workouts',
              style: TextStyle(fontSize: 20.0),
            ),
            actions: [
              !_isEditing
                  ? PopupMenuButton<PopupChoice>(
                      icon: Icon(Icons.more_vert),
                      color: Constants.secondElevation,
                      onSelected: (PopupChoice value) =>
                          _handleChoice(value, context),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<PopupChoice>>[
                        PopupMenuItem<PopupChoice>(
                          value: PopupChoice.ADD,
                          child: Text('Add Workout'),
                        ),
                        PopupMenuItem<PopupChoice>(
                          value: PopupChoice.EDIT,
                          child: Text('Edit Workout'),
                        ),
                        PopupMenuItem<PopupChoice>(
                          value: PopupChoice.SETTINGS,
                          child: Text('Settings'),
                        ),
                      ],
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                      child: GestureDetector(
                        onTap: () => _model.setEditing(false),
                        child: Container(
                          height: 24.0,
                          width: 24.0,
                          child: Icon(
                            Icons.check,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ),
            ],
            bottom: AppBarLoadingIndicator(isLoading: _model.isLoading),
          ),
          body: (BuildContext context) {
            return PreviewListing(isEditing: _isEditing);
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
        HomeModel _model = Provider.of<HomeModel>(context, listen: false);
        _model.setEditing(true);
        break;
      case PopupChoice.SETTINGS:
        AuthService authService =
            Provider.of<AuthService>(context, listen: false);
        authService.signOut();
        // Navigator.pushNamed(context, AppRouter.settings);
        break;
    }
  }
}
