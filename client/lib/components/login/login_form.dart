import 'package:client/utils/app_error.dart';
import 'package:client/components/shared/auth_input_field.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/utils/structures/auth_info.dart';
import 'package:client/utils/validator.dart';
import 'package:client/view_models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginModel _model;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _model = Provider.of<LoginModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: _model.autovalidate,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        bool _autovalidate = snapshot.data;

        return Form(
          key: _formKey,
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
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    enabled: !_isLoading,
                    validator: (value) => Validator.validateEmail(value),
                  ),
                  SizedBox(height: 32.0),
                  AuthInputField(
                    labelText: 'Password',
                    controller: _passwordController,
                    hidden: true,
                    enabled: !_isLoading,
                    validator: (value) => Validator.validatePassword(value),
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
          ),
        );
      },
    );
  }

  void _signIn(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();

      AuthInfo authInfo = AuthInfo(
        email: _emailController.text,
        password: _passwordController.text,
      );

      try {
        await _model.signIn(authInfo);
      } catch (e) {
        AppError.show(context, e.message);
      }
    } else {
      _model.setAutovalidate(true);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
