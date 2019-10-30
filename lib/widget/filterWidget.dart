import 'package:flutter/material.dart';
import '../helpers/share.dart';
import '../helpers/setting.dart';
import '../services/userService.dart';

final TextEditingController widgetControllerFilter =
    new TextEditingController();

getInputFilter(TextEditingController _filter) {
  final inputFilter = new TextField(
    controller: _filter,
    style: new TextStyle(color: Colors.white),
    decoration: new InputDecoration(
      fillColor: Colors.white,
      hintText: 'Search by title or description',
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
    ),
  );
  return inputFilter;
}

Widget buildDrawer(BuildContext context) {
  return new Drawer(
    child: Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Image(
              image: AssetImage("assets/images/bg-drawer.jpeg"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0, left: 16.0),
              child: CircleAvatar(
                radius: 40.0,
                backgroundImage: AssetImage("assets/images/default-user.jpg"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 120.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(Share.getString('user_login_fullname'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white,
                      ))
                ],
              ),
            )
          ],
        ),
        ListView(
          shrinkWrap: true,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.of(context).pushNamed(homePageTag);
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text("Category Manager"),
              onTap: () {
                Navigator.of(context).pushNamed(categoryPageTag);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Change Infomation"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text("Change Password"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text("Logout"),
              onTap: () {
                logout(context);
              },
            ),
          ],
        )
      ],
    ),
  );
}
