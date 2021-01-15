import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class AppBarLoadingIndicator extends StatelessWidget
    implements PreferredSizeWidget {
  final Stream<bool> isLoading;
  final Color backgroundColor;

  AppBarLoadingIndicator({
    @required this.isLoading,
    this.backgroundColor = Constants.firstElevation,
  });

  Size get preferredSize => Size.fromHeight(1.5);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: isLoading,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data) {
          return LinearProgressIndicator(
            minHeight: 1.5,
            backgroundColor: backgroundColor,
            valueColor: AlwaysStoppedAnimation<Color>(Constants.primaryColor),
          );
        }

        return Container();
      },
    );
  }
}
