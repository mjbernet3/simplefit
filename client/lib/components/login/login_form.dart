import 'package:client/app_style.dart';
import 'package:client/components/shared/form_input_field.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FormInputField(
            labelText: Text(
              'Username/Email',
              style: TextStyle(
                color: AppStyle.medEmphasisText,
              ),
            ),
            controller: _emailController,
            textInputAction: TextInputAction.next,
            autofocus: true,
            validator: (value) => value.isEmpty ? 'Empty' : null,
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
          ),
          SizedBox(height: 32.0),
          FormInputField(
            labelText: Text(
              'Password',
              style: TextStyle(
                color: AppStyle.medEmphasisText,
              ),
            ),
            controller: _passwordController,
            hidden: true,
            validator: (value) => value.isEmpty ? 'Empty' : null,
            onSubmitted: (_) => _signIn(),
          ),
          SizedBox(height: 16.0),
          RoundedButton(
            buttonText: Text(
              'Sign In',
              style: TextStyle(
                color: AppStyle.highEmphasisText,
                fontSize: 16.0,
              ),
            ),
            onPressed: _signIn,
          ),
        ],
      ),
    );
  }

  void _signIn() {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
