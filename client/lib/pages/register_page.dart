import 'package:client/utils/constants.dart';
import 'package:client/components/register/register_form.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.backgroundColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Register',
              style: TextStyle(fontSize: 32.0),
            ),
            SizedBox(height: 32.0),
            RegisterForm(),
          ],
        ),
      ),
    );
  }
}
