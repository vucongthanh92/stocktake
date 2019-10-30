import 'package:flutter/material.dart';
import '../services/categoryService.dart';
import '../models/category.dart';
import '../models/categories.dart';
import '../widget/categoryWidget.dart';
import 'categoryAdd.dart';
import '../widget/filterWidget.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoriesListState createState() {
    return _CategoriesListState();
  }
}

class _CategoriesListState extends State<CategoryList> {
  Categories _categories = new Categories();

  @override
  void initState() {
    super.initState();
    _categories.categories = new List();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Categories"),
        centerTitle: true,
      ),
      drawer: buildDrawer(context),
      body: _buildList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => new CategoryAdd()
          ));
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(251, 165, 42, 1),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: this
          ._categories
          .categories
          .map((data) => _buildListItem(context, data))
          .toList(),
    );
  }

  Widget _buildListItem(BuildContext context, Category category) {
    return widgetListCategories(context, category);
  }

  void getCategories() async {
    Categories tempCategories = await apiGetCategories();
    setState(() {
      for (Category category in tempCategories.categories) {
        this._categories.categories.add(category);
      }
    });
  }
}
