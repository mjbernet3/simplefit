import 'package:client/utils/app_style.dart';
import 'package:flutter/material.dart';

class SimplePopUp<T> extends ModalRoute<T> {
  final Widget Function(BuildContext context) builder;
  final RenderBox renderBox;
  final Color backgroundColor;
  final bool isAnimated;

  SimplePopUp({
    @required this.builder,
    this.renderBox,
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
    if (renderBox == null) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: AppStyle.firstElevation,
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
    } else {
      Size size = renderBox.size;
      Offset offset = renderBox.localToGlobal(Offset.zero);

      return Stack(
        children: [
          Positioned(
            top: offset.dy + size.height,
            left: offset.dx,
            child: Material(
              type: MaterialType.transparency,
              elevation: 4.0,
              child: Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: AppStyle.firstElevation,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10.0),
                  ),
                ),
                width: size.width,
                child: builder(context),
              ),
            ),
          ),
        ],
      );
    }
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
