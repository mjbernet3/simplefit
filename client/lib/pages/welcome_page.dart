import 'package:client/app_style.dart';
import 'package:client/components/action_text.dart';
import 'package:client/components/rounded_button.dart';
import 'package:client/router.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RoundedButton(
              buttonText: Text(
                'Create an Account',
                style: TextStyle(
                  color: AppStyle.highEmphasisText,
                ),
              ),
              onPressed: () => Navigator.pushNamed(context, Router.register),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Already have an account?',
                  style: TextStyle(
                    color: AppStyle.medEmphasisText,
                  ),
                ),
                ActionText(
                  text: Text(
                    'Sign In',
                    style: TextStyle(color: AppStyle.primaryColor),
                  ),
                  padding: EdgeInsets.only(left: 5.0),
                  onPressed: () => Navigator.pushNamed(context, Router.login),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
