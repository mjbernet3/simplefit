import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class LinearLoadingIndicator extends StatelessWidget {
  final Stream<bool> isLoading;

  LinearLoadingIndicator({@required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: isLoading,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data) {
          return LinearProgressIndicator(
            minHeight: 1.5,
            backgroundColor: Constants.firstElevation,
            valueColor: AlwaysStoppedAnimation<Color>(Constants.primaryColor),
          );
        }

        return Container();
      },
    );
  }
}
