import 'package:client/components/shared/app_bar_loading_indicator.dart';
import 'package:client/utils/constants.dart';
import 'package:client/components/register/register_form.dart';
import 'package:client/utils/page_builder.dart';
import 'package:client/view_models/register_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RegisterModel model = Provider.of<RegisterModel>(context, listen: false);

    return PageBuilder(
      appBar: AppBar(
        bottom: AppBarLoadingIndicator(
          isLoading: model.isLoading,
          backgroundColor: Constants.backgroundColor,
        ),
      ),
      body: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Register',
              style: TextStyle(fontSize: 32.0),
            ),
            SizedBox(height: 32.0),
            RegisterForm(),
          ],
        );
      },
    );
  }
}
