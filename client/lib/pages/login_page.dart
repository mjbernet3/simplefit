import 'package:client/components/shared/app_bar_loading_indicator.dart';
import 'package:client/components/shared/app_dialog.dart';
import 'package:client/components/login/reset_password_body.dart';
import 'package:client/utils/app_error.dart';
import 'package:client/utils/constants.dart';
import 'package:client/components/login/login_form.dart';
import 'package:client/components/shared/page_builder.dart';
import 'package:client/view_models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginModel model = Provider.of<LoginModel>(context, listen: false);

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
              'Sign In',
              style: TextStyle(fontSize: 32.0),
            ),
            SizedBox(height: 32.0),
            LoginForm(),
            SizedBox(height: 8.0),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () => _showPasswordReset(context),
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
        );
      },
    );
  }

  void _showPasswordReset(BuildContext context) async {
    String errorMessage = await Navigator.push(
      context,
      AppDialog(
        builder: (context) => ResetPasswordBody(),
      ),
    );

    if (errorMessage != null) {
      AppError.show(context, errorMessage);
    }
  }
}
