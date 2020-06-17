import 'package:client/app_style.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:flutter/material.dart';

class ExerciseBrowser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: AppStyle.dp2,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RoundedButton(
                buttonText: Text(
                  'Lifting',
                  style: TextStyle(color: AppStyle.highEmphasisText),
                ),
                height: 30.0,
                color: AppStyle.dp4,
                borderColor: AppStyle.dp4,
                onPressed: () => print('hello'),
              ),
              RoundedButton(
                buttonText: Text(
                  'Cardio',
                  style: TextStyle(color: AppStyle.highEmphasisText),
                ),
                height: 30.0,
                color: AppStyle.dp4,
                borderColor: AppStyle.dp4,
                onPressed: () => print('hello'),
              ),
            ],
          ),
          Divider(
            thickness: 1.5,
            color: AppStyle.dp24,
          ),
        ],
      ),
    );
  }
}
