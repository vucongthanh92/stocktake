import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/helpers/share.dart';
import 'dart:convert';
import '../models/category.dart';
import '../models/categories.dart';
import '../helpers/setting.dart';

resetCurrentCategoriesList(Categories arrCategories) {
  Categories categories = Categories();
  for (Category category in arrCategories.categories) {
    categories.categories.add(category);
  }
}

createCategory(BuildContext context, Category category) {
  if (category.title == "" || category.title == null) {
    printError(context, "You have not entered a title");
  } else {
    Share.init();
    category.createdby = Share.getInt("user_login_sid");
    apiInsertCategory(category).then((dataCategory) {
      if (dataCategory != null) {
        Navigator.of(context).pushNamed(categoryPageTag);
      } else {
        printError(context, "login falied");
      }
    });
  }
}

editCategory(BuildContext context, Category category) {
  if (category.sid.isNaN || category.sid == 0 || category.sid == null) {
    printError(context, "This category does not exist");
  } else if (category.title == null || category.title == "") {
    printError(context, "You have not entered a title");
  } else {
      Share.init();
      category.createdby = Share.getInt("user_login_sid");
      apiUpdateCategory(category).then((dataCategory) {
        Navigator.of(context).pushNamed(categoryPageTag);
      });
  }
}

Future<Categories> apiGetCategories() async {
  final response = await http.get(api + "categories");
  if (response.statusCode == 200) {
    var data = new Map();
    data = json.decode(response.body);
    return Categories.fromJson(data["data"]);
  } else {
    throw Exception("Failed to load data");
  }
}

Future<Category> apiInsertCategory(Category category) async {
  final response = await http.post(api + "category",
      headers: {"Accept": "application/json"},
      body: jsonEncode({
        "title": category.title,
        "description": category.description,
        "parentid": category.parentID,
        "status": category.status,
        "createdby": category.createdby
      }));
  if (response.statusCode == 200) {
    var data = new Map();
    data = json.decode(response.body);
    return Category.fromJson(data["data"]);
  } else {
    return null;
  }
}

Future<Category> apiUpdateCategory(Category category) async {
  final response = await http.put(api + "category",
      headers: {"Accept": "application/json"},
      body: jsonEncode({
        "sid": category.sid,
        "title": category.title,
        "description": category.description,
        "parentid": category.parentID,
        "status": category.status,
        "createdby": category.createdby
      }));
  if (response.statusCode == 200) {
    var data = new Map();
    data = json.decode(response.body);
    return Category.fromJson(data["data"]);
  } else {
    return null;
  }
}

Future apiDeleteCategory(BuildContext context, String sid) async {
  final resposne = await http.delete(api + "category/" + sid);
  if (resposne.statusCode == 200) {
    Navigator.of(context).pushNamed(categoryPageTag);
  } else {
    printError(context, "delete product falied");
  }
}
