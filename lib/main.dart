import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/categoriesList.dart';
import 'helpers/setting.dart';
import 'helpers/share.dart';

void main() => runApp(StockTakeApp());

class StockTakeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      loginPageTag: (context) => Login(),
      homePageTag: (context) => Home(),
      categoryPageTag: (context) => CategoryList(),
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Share.getString("user_login_fullname"),
      theme: new ThemeData(
        primaryColor: colorBackgroundApp,
      ),
      home: Login(),
      routes: routes,
    );
  }
}