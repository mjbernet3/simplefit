import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class AppDialog<T> extends ModalRoute<T> {
  final Widget Function(BuildContext context) builder;

  AppDialog({required this.builder});

  @override
  Color get barrierColor => Constants.backgroundColor.withValues(alpha: 0.5);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => "";

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 150);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child: builder(context),
      ),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.9,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        ),
      ),
      child: child,
    );
  }
}
