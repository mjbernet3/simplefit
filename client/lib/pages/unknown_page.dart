import 'package:client/components/shared/page_builder.dart';
import 'package:flutter/material.dart';

class UnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      body: (BuildContext context) {
        return Center(
          child: Text(
            'You shouldn\'t be here',
            style: TextStyle(fontSize: 40.0),
          ),
        );
      },
    );
  }
}
