import 'package:client/utils/app_error.dart';
import 'package:client/components/shared/auth_input_field.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/utils/constants.dart';
import 'package:client/view_models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginModel model = Provider.of<LoginModel>(context, listen: false);

    return StreamBuilder<bool>(
      initialData: false,
      stream: model.isLoading,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        bool _isLoading = snapshot.data;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AuthInputField(
              labelText: 'Email address',
              maxLength: Constants.maxEmailLength,
              controller: model.emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofocus: true,
              enabled: !_isLoading,
            ),
            SizedBox(height: 32.0),
            AuthInputField(
              labelText: 'Password',
              maxLength: Constants.maxPasswordLength,
              controller: model.passwordController,
              hidden: true,
              enabled: !_isLoading,
              onSubmitted: (_) => _signIn(context),
            ),
            SizedBox(height: 16.0),
            RoundedButton(
              buttonText: 'Sign In',
              fontSize: 16.0,
              disabled: _isLoading,
              onPressed: () => _signIn(context),
            ),
          ],
        );
      },
    );
  }

  void _signIn(BuildContext context) async {
    FocusScope.of(context).unfocus();

    LoginModel model = Provider.of<LoginModel>(context, listen: false);

    try {
      await model.signIn();
    } catch (e) {
      AppError.show(context, e.message);
    }
  }
}
