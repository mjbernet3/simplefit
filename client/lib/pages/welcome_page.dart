import 'package:client/utils/constants.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/utils/app_router.dart';
import 'package:client/utils/page_builder.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      body: (BuildContext context) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
          child: Stack(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'SimpleFit',
                      style: TextStyle(
                        fontSize: 32.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'No Premium. No Ads. No Intrusions.',
                      style: TextStyle(
                        color: Constants.medEmphasis,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RoundedButton(
                    buttonText: 'Create an Account',
                    fontSize: 16.0,
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRouter.register),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Constants.medEmphasis,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, AppRouter.login),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Constants.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
