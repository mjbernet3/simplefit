import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class DropdownPopup<T> extends ModalRoute<T> {
  final Widget Function(BuildContext context) builder;
  final RenderBox renderBox;

  DropdownPopup({
    required this.builder,
    required this.renderBox,
  });

  @override
  Color get barrierColor => Colors.transparent;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => "";

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
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
              padding: const EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                color: Constants.firstElevation,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Constants.backgroundColor,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 5.0),
                  ),
                ],
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
