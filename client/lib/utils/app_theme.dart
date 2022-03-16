import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  final BuildContext context;

  AppTheme(this.context);

  ThemeData get darkTheme => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Constants.backgroundColor,
        canvasColor: Constants.backgroundColor,
        appBarTheme: AppBarTheme(
          color: Constants.backgroundColor,
          elevation: 0.0,
          titleTextStyle: TextStyle(color: Constants.highEmphasis),
          iconTheme: IconThemeData(
            size: 28.0,
            color: Constants.primaryColor,
          ),
        ),
        cardTheme: CardTheme(
          color: Constants.firstElevation,
          margin: EdgeInsets.zero,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Constants.highEmphasis,
              displayColor: Constants.highEmphasis,
            ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Constants.highEmphasis,
          selectionColor: Constants.highEmphasis,
        ),
        iconTheme: IconThemeData(
          size: 28.0,
          color: Constants.primaryColor,
        ),
        disabledColor: Constants.firstElevation.withOpacity(0.5),
        errorColor: Constants.dangerColor,
        shadowColor: Constants.backgroundColor,
        dividerTheme: DividerThemeData(
          color: Constants.thirdElevation,
          thickness: 1.5,
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Constants.secondElevation,
          contentTextStyle: TextStyle(color: Constants.highEmphasis),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Constants.firstElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
      );
}
