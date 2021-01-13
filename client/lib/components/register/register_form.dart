import 'package:client/utils/app_error.dart';
import 'package:client/components/shared/auth_input_field.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/utils/structures/auth_info.dart';
import 'package:client/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController;
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  bool _isLoading = false;
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidate,
      child: Column(
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
            labelText: 'Username',
            controller: _usernameController,
            textInputAction: TextInputAction.next,
            enabled: !_isLoading,
            validator: (value) => Validator.validateUsername(value),
          ),
          SizedBox(height: 32.0),
          AuthInputField(
            labelText: 'Password',
            controller: _passwordController,
            hidden: true,
            enabled: !_isLoading,
            validator: (value) => Validator.validatePassword(value),
            onSubmitted: (_) => _register(),
          ),
          SizedBox(height: 16.0),
          RoundedButton(
            buttonText: 'Create Account',
            fontSize: 16.0,
            disabled: _isLoading,
            onPressed: _register,
          ),
        ],
      ),
    );
  }

  void _register() async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      AuthService authService =
          Provider.of<AuthService>(context, listen: false);

      AuthInfo authInfo = AuthInfo(
        email: _emailController.text,
        username: _usernameController.text,
        password: _passwordController.text,
      );

      setState(() => _isLoading = true);

      try {
        await authService.register(authInfo);
      } catch (e) {
        setState(() => _isLoading = false);

        AppError.show(context, e.message);
      }
    } else {
      setState(() => _autovalidate = AutovalidateMode.always);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
