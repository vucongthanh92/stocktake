import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final api = 'http://18.140.72.29:3030/api/';

Color colorBarApp = Color.fromRGBO(58, 66, 86, 1);
Color colorBackgroundApp = Color.fromRGBO(58, 66, 86, 1);
Color colorButtonAPP = Color.fromRGBO(64, 75, 96, 0.9);

var loginButtonText = "Login";

Image appLogo = Image.asset('assets/images/flutter-logo-round.png');

const bigRadius = 66.0;
const buttonHeight = 24.0;

const loginPageTag = 'Login';
const homePageTag = 'Home';
const categoryPageTag = 'CategoryList';

printError(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(message),
      );
    },
  );
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future showNotificationWithDefaultSound(
    String title, String description) async {
  var androidPlatformChannelSpecials = new AndroidNotificationDetails(
      "notification_channel_id", "Channel Name", "Hello World",
      importance: Importance.Max, priority: Priority.High);
  var iosPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecials, iosPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, "StockTake Notification", title, platformChannelSpecifics,
      payload: description);
}
