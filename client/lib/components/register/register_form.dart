import 'package:client/utils/app_error.dart';
import 'package:client/components/shared/auth_input_field.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/utils/constants.dart';
import 'package:client/utils/validator.dart';
import 'package:client/view_models/register_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RegisterModel model = Provider.of<RegisterModel>(context, listen: false);

    return StreamBuilder<bool>(
      initialData: false,
      stream: model.autovalidate,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        bool autovalidate = snapshot.data ?? false;

        return Form(
          key: model.formKey,
          autovalidateMode: autovalidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: StreamBuilder<bool>(
            initialData: false,
            stream: model.isLoading,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              bool isLoading = snapshot.data ?? false;

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
                    enabled: !isLoading,
                    validator: _checkEmail,
                  ),
                  const SizedBox(height: 32.0),
                  AuthInputField(
                    labelText: 'Username',
                    maxLength: Constants.maxUsernameLength,
                    controller: model.usernameController,
                    textInputAction: TextInputAction.next,
                    enabled: !isLoading,
                    validator: _checkUsername,
                  ),
                  const SizedBox(height: 32.0),
                  AuthInputField(
                    labelText: 'Password',
                    maxLength: Constants.maxPasswordLength,
                    controller: model.passwordController,
                    hidden: true,
                    enabled: !isLoading,
                    validator: _checkPassword,
                    onSubmitted: (_) => _register(context),
                  ),
                  const SizedBox(height: 16.0),
                  RoundedButton(
                    buttonText: 'Create Account',
                    fontSize: 16.0,
                    disabled: isLoading,
                    onPressed: () => _register(context),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  String _checkEmail(String? email) {

    // TODO: Improve error handling
    try {
      Validator.validateEmail(email);
    } catch (e) {
      return e.toString();
    }

    return "";
  }

  String _checkUsername(String? username) {

    // TODO: Improve error handling
    try {
      Validator.validateUsername(username);
    } catch (e) {
      return e.toString();
    }

    return "";
  }

  String _checkPassword(String? password) {

    // TODO: Improve error handling
    try {
      Validator.validatePassword(password);
    } catch (e) {
      return e.toString();
    }

    return "";
  }

  void _register(BuildContext context) async {
    FocusScope.of(context).unfocus();

    RegisterModel model = Provider.of<RegisterModel>(context, listen: false);

    // TODO: Improve error handling
    try {
      await model.register();
    } catch (e) {
      AppError.show(context, e.toString());
    }
  }
}
