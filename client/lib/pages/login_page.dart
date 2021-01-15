import 'package:client/components/shared/app_bar_loading_indicator.dart';
import 'package:client/utils/constants.dart';
import 'package:client/components/login/login_form.dart';
import 'package:client/view_models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginModel _model = Provider.of<LoginModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.backgroundColor,
        elevation: 0.0,
        bottom: AppBarLoadingIndicator(
          isLoading: _model.isLoading,
          backgroundColor: Constants.backgroundColor,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Sign In',
              style: TextStyle(fontSize: 32.0),
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
                    color: Constants.medEmphasis,
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
