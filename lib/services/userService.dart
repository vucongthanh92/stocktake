import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/user.dart';
import '../helpers/setting.dart';
import '../helpers/share.dart';

checkLogin(BuildContext context) {
  Share.init();
  var loginStatus = false;
  loginStatus = Share.getBool("user_login_status");
  if (loginStatus != null && loginStatus == true) {
    Navigator.of(context).pushNamed(homePageTag);
  }
}

login(BuildContext context, String username, String password) async {
  Share.init();
  apiLogin(username, password).then((dataUser) {
    if (dataUser != null) {
      setLocalStorage(dataUser).then((data) {
        Navigator.of(context).pushNamed(homePageTag);
      });
    } else {
      printError(context, "login falied");
    }
  });
}

logout(BuildContext context) {
  Share.dispose();
  SystemNavigator.pop();
}

Future<bool> setLocalStorage(User currentUser) async {
  await Share.setBool("user_login_status", true);
  await Share.setInt("user_login_sid", currentUser.sid);
  await Share.setString("user_login_username", currentUser.username);
  await Share.setString("user_login_fullname", currentUser.fullname);
  await Share.setInt("user_login_roleID", currentUser.roleID);
  await Share.setString("user_login_rolename", currentUser.rolename);
  return true;
}

Future<User> apiLogin(String username, String password) async {
  final response = await http.post(api + "login",
      headers: {"Accept": "application/json"},
      body: jsonEncode({"username": username, "password": password}));
  if (response.statusCode == 200) {
    var data = new Map();
    data = json.decode(response.body);
    return User.fromJson(data["data"]);
  } else {
    return null;
  }
}
