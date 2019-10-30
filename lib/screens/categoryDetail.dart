import 'package:flutter/material.dart';
import 'package:my_app/models/category.dart';
import '../services/categoryService.dart';
import 'categoryEdit.dart';

class CategoryDetail extends StatelessWidget {
  final Category category;
  CategoryDetail({this.category});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Category Detail"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              apiDeleteCategory(context, category.sid.toString());
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
                            category.title,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 15),
                        new Text(
                          "Parent Category: " + category.parentID.toString(),
                          style: new TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(height: 15),
                        new Text(
                          "Created By: " + category.createdby.toString(),
                          style: new TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(height: 15),
                        new Text(
                          category.description,
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
            builder: (context) => new CategoryEdit(category: category)
          ));
        },
        child: Icon(Icons.edit),
        backgroundColor: Color.fromRGBO(251, 165, 42, 1),
      ),
    );
  }
}
