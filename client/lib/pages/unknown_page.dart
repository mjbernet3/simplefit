import 'package:client/utils/page_builder.dart';
import 'package:flutter/material.dart';

class UnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      body: (BuildContext context) {
        return Center(
          child: Text(
            'You should not be here...',
            style: TextStyle(fontSize: 40.0),
          ),
        );
      },
    );
  }
}
