import 'package:flutter/material.dart';
import '../screens/productEdit.dart';
import '../models/product.dart';
import '../services/productService.dart';

class ProductDetail extends StatelessWidget {
  final Product product;
  ProductDetail({this.product});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(product.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              apiDeleteProduct(context, product.sid.toString());
            },
          )
        ],
      ),
      body: new ListView(
        children: <Widget>[
          Image(
            image: NetworkImage(
                "https://screenshotlayer.com/images/assets/placeholder.png"),
          ),
          GestureDetector(
            child: new Container(
              padding: const EdgeInsets.all(30.0),
              child: new Row(
                children: [
                  new Expanded(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Container(
                          child: new Text(
                            product.title,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 15),
                        new Text(
                          "Category: " + product.category["Title"],
                          style: new TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(height: 15),
                        new Text(
                          "Price: " + product.price.toString(),
                          style: new TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(height: 15),
                        new Text(
                          "Quantity: " + product.quantity.toString(),
                          style: new TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(height: 15),
                        new Text(
                          product.description,
                          style: new TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => new ProductEdit(product: product)
          ));
        },
        child: Icon(Icons.edit),
        backgroundColor: Color.fromRGBO(251, 165, 42, 1),
      ),
    );
  }
}
