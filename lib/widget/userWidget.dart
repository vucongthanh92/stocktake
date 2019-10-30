import 'package:flutter/material.dart';
import '../helpers/setting.dart';

// logo object
final logo = CircleAvatar(
  backgroundColor: Colors.transparent,
  radius: bigRadius,
  child: appLogo,
);

// username object
final _userController = TextEditingController();
final username = TextFormField(
  controller: _userController,
  keyboardType: TextInputType.text,
  autofocus: true,
  decoration: InputDecoration(
    prefixIcon: const Icon(
      Icons.people,
      color: Colors.white,
    ),
    hintText: "Username",
    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    hintStyle: TextStyle(
        color: Color.fromRGBO(250, 250, 250, 0.5)
    )
  ),
  style: TextStyle(
    color: Colors.white,
  ),
);

// password object
final _passwordController = TextEditingController();
final password = TextFormField(
  controller: _passwordController,
  keyboardType: TextInputType.text,
  obscureText: true,
  decoration: InputDecoration(
    prefixIcon: const Icon(
      Icons.lock,
      color: Colors.white,
    ),
    hintText: "Password",
    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    hintStyle: TextStyle(
        color: Color.fromRGBO(250, 250, 250, 0.5)
    )
  ),
  style: TextStyle(
    color: Colors.white,
  ),
);
