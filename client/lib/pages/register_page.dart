import 'package:client/app_style.dart';
import 'package:client/components/register/register_form.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/state_models/register_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
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
              'Register',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.0,
              ),
            ),
            SizedBox(height: 32.0),
            ChangeNotifierProvider<RegisterModel>(
              create: (context) => RegisterModel(
                authService: Provider.of<AuthService>(
                  context,
                  listen: false,
                ),
              ),
              child: RegisterForm(),
            ),
          ],
        ),
      ),
    );
  }
}
