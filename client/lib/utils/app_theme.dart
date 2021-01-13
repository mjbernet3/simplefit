import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  final BuildContext context;

  AppTheme(this.context);

  ThemeData get darkTheme => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Constants.backgroundColor,
        cardColor: Constants.firstElevation,
        appBarTheme: AppBarTheme(
          color: Constants.firstElevation,
          textTheme: Theme.of(context).primaryTextTheme.apply(
                bodyColor: Constants.highEmphasis,
                displayColor: Constants.highEmphasis,
              ),
          iconTheme: IconThemeData(
            color: Constants.highEmphasis,
          ),
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Constants.highEmphasis,
              displayColor: Constants.highEmphasis,
            ),
        iconTheme: IconThemeData(
          color: Constants.highEmphasis,
        ),
        cursorColor: Constants.highEmphasis,
        disabledColor: Constants.secondElevation,
        errorColor: Constants.dangerColor,
        shadowColor: Constants.firstElevation,
        dividerTheme: DividerThemeData(
          color: Constants.thirdElevation,
          thickness: 1.5,
        ),
      );
}
