import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';
import '../models/products.dart';
import '../helpers/setting.dart';
import '../helpers/share.dart';

resetCurentProductList(Products arrProducts) {
  Products products = Products();
  for (Product product in arrProducts.products) {
    products.products.add(product);
  }
  return products;
}

editProduct(BuildContext context, Product product) {
  if (product.sid.isNaN || product.sid == 0 || product.sid == null) {
    printError(context, "This product does not exist");
  } else if (product.title == null || product.title == "") {
    printError(context, "You have not entered a title");
  } else if (product.categoryID == null || product.categoryID == 0) {
    printError(context, "You have not selected the category");
  } else {
    Share.init();
    product.createdby = Share.getInt("user_login_sid");
    apiUpdateProduct(product).then((dataProduct) {
      if (dataProduct != null) {
        Navigator.of(context).pushNamed(homePageTag);
      } else {
        printError(context, "login falied");
      }
    });
  }
}

createProduct(
  BuildContext context,
  String title,
  String description,
  int categoryID,
  String image,
  int price,
  int quantity,
  int status,
) {
  if (title == "") {
    printError(context, "You have not entered a title");
  } else if (categoryID == 0) {
    printError(context, "You have not selected the category");
  } else {
    Share.init();
    Product product = new Product();
    product.title = title;
    product.description = description;
    product.categoryID = categoryID;
    product.images = "";
    product.price = double.parse(price.toString());
    product.quantity = quantity;
    product.status = status;
    product.createdby = Share.getInt("user_login_sid");
    apiInsertProduct(product).then((dataProduct) {
      if (dataProduct != null) {
        var fullname = Share.getString("user_login_fullname");
        showNotificationWithDefaultSound(
            "Create a Product", fullname + " created " + product.title);
        Navigator.of(context).pushNamed(homePageTag);
      } else {
        printError(context, "login falied");
      }
    });
  }
}

Future<Products> apiGetProducts() async {
  final response = await http.get(api + "products");
  if (response.statusCode == 200) {
    var data = new Map();
    data = json.decode(response.body);
    return Products.fromJson(data["data"]);
  } else {
    throw Exception("Failed to load data");
  }
}

Future<Product> apiInsertProduct(Product product) async {
  final response = await http.post(api + "product",
      headers: {"Accept": "application/json"},
      body: jsonEncode({
        "title": product.title,
        "description": product.description,
        "categoryid": product.categoryID,
        "images": "",
        "price": product.price,
        "quantity": product.quantity,
        "status": product.status,
        "createdby": product.createdby
      }));
  if (response.statusCode == 200) {
    var data = new Map();
    data = json.decode(response.body);
    return Product.fromJson(data["data"]);
  } else {
    return null;
  }
}

Future<Product> apiUpdateProduct(Product product) async {
  final response = await http.put(api + "product",
      headers: {"Accept": "application/json"},
      body: jsonEncode({
        "sid": product.sid,
        "title": product.title,
        "description": product.description,
        "categoryid": product.categoryID,
        "images": "",
        "price": product.price,
        "quantity": product.quantity,
        "status": product.status,
        "createdby": product.createdby
      }));
  if (response.statusCode == 200) {
    var data = new Map();
    data = json.decode(response.body);
    return Product.fromJson(data["data"]);
  } else {
    return null;
  }
}

Future apiDeleteProduct(BuildContext context, String sid) async {
  final response = await http.delete(api + "product/" + sid);
  if (response.statusCode == 200) {
    Navigator.of(context).pushNamed(homePageTag);
  } else {
    printError(context, "delete product falied");
  }
}
