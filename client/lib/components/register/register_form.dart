import 'package:client/app_style.dart';
import 'package:client/components/shared/auth_input_field.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/utils/structures/auth_info.dart';
import 'package:client/utils/structures/response.dart';
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
  bool isLoading = false;
  bool autovalidate = false;

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
      autovalidate: autovalidate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AuthInputField(
            labelText: 'Email address',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofocus: true,
            enabled: !isLoading,
            validator: (value) => Validator.validateEmail(value),
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
          ),
          SizedBox(height: 32.0),
          AuthInputField(
            labelText: 'Username',
            controller: _usernameController,
            textInputAction: TextInputAction.next,
            enabled: !isLoading,
            validator: (value) => Validator.validateUsername(value),
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
          ),
          SizedBox(height: 32.0),
          AuthInputField(
            labelText: 'Password',
            controller: _passwordController,
            hidden: true,
            enabled: !isLoading,
            validator: (value) => Validator.validatePassword(value),
            onSubmitted: (_) => _register(),
          ),
          SizedBox(height: 16.0),
          RoundedButton(
            buttonText: Text(
              'Create Account',
              style: TextStyle(
                color: AppStyle.highEmphasisText,
                fontSize: 16.0,
              ),
            ),
            disabled: isLoading,
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

      setState(() => isLoading = true);
      Response response = await authService.register(authInfo);
      setState(() => isLoading = false);

      if (response.status == Status.FAILURE) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.message,
              style: TextStyle(
                color: AppStyle.highEmphasisText,
              ),
            ),
            backgroundColor: AppStyle.dp8,
            duration: Duration(seconds: 5),
          ),
        );
      }
    } else {
      setState(() => autovalidate = true);
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
