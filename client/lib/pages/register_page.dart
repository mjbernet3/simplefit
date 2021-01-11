import 'package:client/utils/app_style.dart';
import 'package:client/components/register/register_form.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
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
              'Register',
              style: TextStyle(
                color: AppStyle.highEmphasis,
                fontSize: 32.0,
              ),
            ),
            SizedBox(height: 32.0),
            RegisterForm(),
          ],
        ),
      ),
    );
  }
}
