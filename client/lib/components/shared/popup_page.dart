import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class PopupPage<T> extends ModalRoute<T> {
  final Widget Function(BuildContext context) builder;
  final Color backgroundColor;
  final bool isAnimated;

  PopupPage({
    @required this.builder,
    this.backgroundColor,
    this.isAnimated = true,
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
  Duration get transitionDuration =>
      Duration(milliseconds: isAnimated ? 250 : 0);

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
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Constants.firstElevation,
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
    return isAnimated
        ? ScaleTransition(
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
          )
        : child;
  }
}
