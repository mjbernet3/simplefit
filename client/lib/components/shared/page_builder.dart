import 'package:flutter/material.dart';

class PageBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) body;
  final AppBar appBar;

  PageBuilder({
    @required this.body,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: _getContentHeight(context),
            width: _getContentWidth(context),
            padding: const EdgeInsets.all(15.0),
            child: Builder(
              builder: (BuildContext context) {
                return body(context);
              },
            ),
          ),
        ),
      ),
    );
  }

  double _getContentHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double safePadding = MediaQuery.of(context).padding.vertical;

    if (appBar == null) {
      return screenHeight - safePadding;
    }

    return screenHeight - safePadding - appBar.preferredSize.height;
  }

  double _getContentWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double safePadding = MediaQuery.of(context).padding.horizontal;

    return screenWidth - safePadding;
  }
}
