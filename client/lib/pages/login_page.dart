import 'package:client/utils/app_style.dart';
import 'package:client/components/login/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppStyle.highEmphasis,
        ),
        backgroundColor: AppStyle.backgroundColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Sign In',
              style: TextStyle(
                color: AppStyle.highEmphasis,
                fontSize: 32.0,
              ),
            ),
            SizedBox(height: 32.0),
            LoginForm(),
            SizedBox(height: 8.0),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () => print('Forgot password'),
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: AppStyle.medEmphasis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
