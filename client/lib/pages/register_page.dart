import 'package:client/components/shared/app_bar_loading_indicator.dart';
import 'package:client/utils/constants.dart';
import 'package:client/components/register/register_form.dart';
import 'package:client/view_models/register_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RegisterModel _model = Provider.of<RegisterModel>(context, listen: false);

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
