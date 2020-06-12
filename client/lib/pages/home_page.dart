import 'package:client/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService _authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Home',
              style: TextStyle(
                fontSize: 40.0,
              ),
            ),
            RaisedButton(
              onPressed: () async => await _authService.signOut(),
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
