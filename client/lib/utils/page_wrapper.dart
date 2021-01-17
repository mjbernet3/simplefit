import 'package:flutter/material.dart';

class PageWrapper extends StatelessWidget {
  final Widget body;
  final AppBar appBar;

  PageWrapper({
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
            child: body,
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
