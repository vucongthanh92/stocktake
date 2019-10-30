import 'package:flutter/material.dart';
import 'package:my_app/models/categories.dart';
import 'package:my_app/models/category.dart';
import '../helpers/setting.dart';
import '../widget/productWidget.dart';
import '../services/categoryService.dart';
import '../services/productService.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ProductAdd extends StatefulWidget {
  @override
  _ProductAddState createState() {
    return _ProductAddState();
  }
}

class _ProductAddState extends State<ProductAdd> {
  List<DropdownMenuItem<int>> categories = [];
  int selectedCategory = 0;
  int checkedStatus = 1;

  @override
  void initState() {
    super.initState();
    titleWidget.controller.text = "";
    descriptionWidget.controller.text = "";
    priceWidget.controller.text = "";
    quantityWidget.controller.text = "";
    getCategories();

    var initializationSettingAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingAndroid, initializationSettingIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelecNotification);
  }

  void getCategories() async {
    if (categories.length == 0) {
      categories.add(new DropdownMenuItem(
        child: new Text('Chosse Category...'),
        value: 0,
      ));
      Categories tempCategories = await apiGetCategories();
      for (Category category in tempCategories.categories) {
        categories.add(new DropdownMenuItem(
          child: new Text(category.title),
          value: category.sid,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final submitButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          createProduct(
            context,
            titleWidget.controller.text,
            descriptionWidget.controller.text,
            selectedCategory,
            "",
            int.parse(priceWidget.controller.text),
            int.parse(quantityWidget.controller.text),
            checkedStatus,
          );
        },
        padding: EdgeInsets.all(12),
        color: colorButtonAPP,
        child: Text("Submit", style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: colorBarApp,
        centerTitle: true,
        title: Text("New Product"),
      ),
      body: Center(
          child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 20, right: 20),
        children: <Widget>[
          SizedBox(height: 10),
          titleWidget,
          SizedBox(height: 20),
          categoriesWidget(),
          SizedBox(height: 20),
          descriptionWidget,
          SizedBox(height: 20),
          priceWidget,
          SizedBox(height: 10),
          quantityWidget,
          SizedBox(height: 20),
          enableWidget(),
          disableWidget(),
          SizedBox(height: 10),
          submitButton
        ],
      )),
    );
  }

  Future onSelecNotification(String payload) async {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: const Text("Create a Product"),
              content: new Text("$payload"),
            ));
  }

  // category selection object
  categoriesWidget() {
    return new DropdownButton<int>(
      hint: Text("Chosse Category..."),
      items: categories,
      isExpanded: true,
      value: selectedCategory,
      onChanged: (value) {
        setState(() {
          selectedCategory = value;
        });
      },
    );
  }

  // enable radio object
  enableWidget() {
    return RadioListTile<int>(
      title: Text("Enable"),
      value: 1,
      groupValue: checkedStatus,
      onChanged: (value) {
        setState(() {
          checkedStatus = value;
        });
      },
    );
  }

  disableWidget() {
    return RadioListTile<int>(
      title: Text("Disable"),
      value: 0,
      groupValue: checkedStatus,
      onChanged: (value) {
        setState(() {
          checkedStatus = value;
        });
      },
    );
  }
}
