import 'package:flutter/material.dart';
import 'package:my_app/models/categories.dart';
import 'package:my_app/models/category.dart';
import '../helpers/setting.dart';
import '../widget/productWidget.dart';
import '../services/categoryService.dart';

class CategoryEdit extends StatefulWidget {
  final Category category;
  CategoryEdit({this.category});

  @override
  _CategoryEditState createState() {
    return _CategoryEditState();
  }
}

class _CategoryEditState extends State<CategoryEdit> {
  List<DropdownMenuItem<int>> arrCategories = [];
  Category category = new Category();
  int selectedCategory = 0;
  int checkedStatus = 1;

  @override
  void initState() {
    super.initState();
    titleWidget.controller.text = widget.category.title;
    descriptionWidget.controller.text = widget.category.description;
    getCategories();
  }

  void getCategories() async {
    if (arrCategories.length == 0) {
      arrCategories.add(new DropdownMenuItem(
        child: new Text('Parent Categories'),
        value: 0,
      ));
      Categories tempCategories = await apiGetCategories();
      for (Category category in tempCategories.categories) {
        arrCategories.add(new DropdownMenuItem(
          child: new Text(category.title),
          value: category.sid,
        ));
      }
      setState(() {
       selectedCategory = widget.category.parentID; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final submitButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        onPressed: () {
          category.sid = widget.category.sid;
          category.title = titleWidget.controller.text;
          category.description = descriptionWidget.controller.text;
          category.parentID = selectedCategory;
          category.status = checkedStatus;
          editCategory(context, category);
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
        backgroundColor: colorButtonAPP,
        centerTitle: true,
        title: Text("Edit Category"),
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
            enableWidget(),
            disableWidget(),
            SizedBox(height: 10),
            submitButton
          ],
        ),
      ),
    );
  }

  // category selection object
  categoriesWidget() {
    return new DropdownButton<int>(
      hint: Text("Parent Categories..."),
      items: arrCategories,
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
