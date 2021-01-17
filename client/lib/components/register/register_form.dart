import 'package:client/utils/app_error.dart';
import 'package:client/components/shared/auth_input_field.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/utils/validator.dart';
import 'package:client/view_models/register_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RegisterModel _model = Provider.of<RegisterModel>(context, listen: false);

    return StreamBuilder<bool>(
      initialData: false,
      stream: _model.autovalidate,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        bool _autovalidate = snapshot.data;

        return Form(
          key: _model.formKey,
          autovalidateMode: _autovalidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: StreamBuilder<bool>(
            initialData: false,
            stream: _model.isLoading,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              bool _isLoading = snapshot.data;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AuthInputField(
                    labelText: 'Email address',
                    controller: _model.emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    enabled: !_isLoading,
                    validator: (value) => Validator.validateEmail(value),
                  ),
                  SizedBox(height: 32.0),
                  AuthInputField(
                    labelText: 'Username',
                    controller: _model.usernameController,
                    textInputAction: TextInputAction.next,
                    enabled: !_isLoading,
                    validator: (value) => Validator.validateUsername(value),
                  ),
                  SizedBox(height: 32.0),
                  AuthInputField(
                    labelText: 'Password',
                    controller: _model.passwordController,
                    hidden: true,
                    enabled: !_isLoading,
                    validator: (value) => Validator.validatePassword(value),
                    onSubmitted: (_) => _register(context),
                  ),
                  SizedBox(height: 16.0),
                  RoundedButton(
                    buttonText: 'Create Account',
                    fontSize: 16.0,
                    disabled: _isLoading,
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

  void _register(BuildContext context) async {
    FocusScope.of(context).unfocus();

    RegisterModel _model = Provider.of<RegisterModel>(context, listen: false);

    try {
      await _model.register();
    } catch (e) {
      AppError.show(context, e.message);
    }
  }
}
