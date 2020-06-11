import 'package:client/app_style.dart';
import 'package:client/components/login/login_form.dart';
import 'package:client/components/shared/action_text.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/state_models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                color: Colors.white,
                fontSize: 32.0,
              ),
            ),
            SizedBox(height: 32.0),
            ChangeNotifierProvider<LoginModel>(
              create: (context) => LoginModel(
                authService: Provider.of<AuthService>(
                  context,
                  listen: false,
                ),
              ),
              child: LoginForm(),
            ),
            Align(
              alignment: Alignment.center,
              child: ActionText(
                text: Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: AppStyle.medEmphasisText,
                  ),
                ),
                padding: EdgeInsets.only(top: 8.0),
                onPressed: () => print('hello'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
