import 'package:flutter/material.dart';
import 'package:my_app/models/categories.dart';
import 'package:my_app/models/category.dart';
import 'package:my_app/models/product.dart';
import '../helpers/setting.dart';
import '../widget/productWidget.dart';
import '../services/categoryService.dart';
import '../services/productService.dart';

class ProductEdit extends StatefulWidget {
  final Product product;
  ProductEdit({this.product});

  @override
  _ProductEditState createState() {
    return _ProductEditState();
  }
}

class _ProductEditState extends State<ProductEdit> {
  List<DropdownMenuItem<int>> categories = [];
  int selectedCategory = 0;
  int checkedStatus = 1;

  @override
  void initState() {
    super.initState();
    titleWidget.controller.text = widget.product.title;
    descriptionWidget.controller.text = widget.product.description;
    priceWidget.controller.text = widget.product.price.toString();
    quantityWidget.controller.text = widget.product.quantity.toString();
    checkedStatus = widget.product.status;
    getCategories();
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
      setState(() {
        selectedCategory = widget.product.categoryID;
      });
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
          widget.product.title = titleWidget.controller.text;
          widget.product.categoryID = selectedCategory;
          widget.product.description = descriptionWidget.controller.text;
          widget.product.images = "";
          widget.product.price = double.parse(priceWidget.controller.text);
          widget.product.quantity = int.parse(quantityWidget.controller.text);
          widget.product.status = checkedStatus;
          editProduct(context, widget.product);
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
        title: Text("Edit Product"),
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
