import 'package:flutter/material.dart';
import 'package:my_app/models/category.dart';
import '../screens/categoryDetail.dart';

widgetListCategories(BuildContext context, Category category) {
  return Card(
    key: ValueKey(category.title),
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, 0.9)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        title: Text(
          category.title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => new CategoryDetail(category: category)
          ));
        },
      ),
    ),
  );
}
