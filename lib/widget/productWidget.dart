import 'package:flutter/material.dart';
import '../screens/productDetail.dart';
import '../models/product.dart';

widgetListProducts(BuildContext context, Product product) {
  return Card(
    key: ValueKey(product.title),
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, 0.9)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Hero(
            tag: "avatar_" + product.title,
            child: CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage(
                  "https://screenshotlayer.com/images/assets/placeholder.png"),
            ),
          ),
        ),
        title: Text(
          product.title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            new Flexible(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: product.category["Title"],
                      style: TextStyle(color: Colors.white),
                    ),
                    maxLines: 3,
                    softWrap: true,
                  )
                ],
              ),
            )
          ],
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new ProductDetail(product: product)));
        },
      ),
    ),
  );
}

// title text object
final _titleController = TextEditingController();
final titleWidget = TextFormField(
  controller: _titleController,
  keyboardType: TextInputType.text,
  autofocus: true,
  decoration: InputDecoration(
      hintText: "title...",
      contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5))),
  style: TextStyle(
    color: Colors.black,
  ),
);

// description textarea object
final _descriptionController = TextEditingController();
final descriptionWidget = TextFormField(
  controller: _descriptionController,
  keyboardType: TextInputType.text,
  maxLines: 5,
  decoration: InputDecoration(
      hintText: "description...",
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5))),
  style: TextStyle(
    color: Colors.black,
  ),
);

// price text object
final _priceController = TextEditingController();
final priceWidget = TextFormField(
  controller: _priceController,
  keyboardType: TextInputType.number,
  decoration: InputDecoration(
      hintText: "price...",
      contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5))),
  style: TextStyle(
    color: Colors.black,
  ),
);

// quantity text object
final _quantityController = TextEditingController();
final quantityWidget = TextFormField(
  controller: _quantityController,
  keyboardType: TextInputType.number,
  decoration: InputDecoration(
      hintText: "quantity...",
      contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5))),
  style: TextStyle(
    color: Colors.black,
  ),
);
