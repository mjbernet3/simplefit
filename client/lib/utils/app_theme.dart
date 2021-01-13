import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  final BuildContext context;

  AppTheme(this.context);

  ThemeData get darkTheme => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Constants.backgroundColor,
        cardColor: Colors.blue,
        appBarTheme: AppBarTheme(
          color: Colors.blue,
          textTheme: Theme.of(context).primaryTextTheme.apply(
                bodyColor: Colors.pink,
                displayColor: Colors.pink,
              ),
          iconTheme: IconThemeData(
            color: Colors.pink,
          ),
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.pink,
              displayColor: Colors.pink,
            ),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
        iconTheme: IconThemeData(
          color: Colors.pink,
        ),
        cursorColor: Colors.pink,
        disabledColor: Colors.pink,
        errorColor: Colors.pink,
        shadowColor: Colors.pink,
        dividerTheme: DividerThemeData(
          color: Colors.pink,
          thickness: 1.5,
        ),
      );
}
