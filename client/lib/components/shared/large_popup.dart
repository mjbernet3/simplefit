import 'package:client/app_style.dart';
import 'package:flutter/material.dart';

class LargePopUp<T> extends ModalRoute<T> {
  final Widget Function(BuildContext context) builder;
  final Color backgroundColor;
  final int animationLength;

  LargePopUp({
    @required this.builder,
    this.animationLength = 250,
    this.backgroundColor,
  });

  @override
  Color get barrierColor => backgroundColor;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => Duration(milliseconds: animationLength);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: AppStyle.dp2,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.9,
          child: builder(context),
        ),
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
        begin: 0.8,
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
