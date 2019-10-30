import 'package:flutter/material.dart';
import '../helpers/setting.dart';
import '../widget/userWidget.dart';
import '../services/userService.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    checkLogin(context);
    // button object
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          login(context, username.controller.text, password.controller.text);
        },
        padding: EdgeInsets.all(12),
        color: colorButtonAPP,
        child: Text(loginButtonText, style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: colorBarApp,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24, right: 24),
          children: <Widget>[
            logo,
            SizedBox(height: 60),
            username,
            SizedBox(height: 15),
            password,
            SizedBox(height: 20),
            loginButton
          ],
        ),
      ),
    );
  }
}
