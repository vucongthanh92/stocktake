import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'productAdd.dart';
import '../helpers/setting.dart';
import '../models/product.dart';
import '../models/products.dart';
import '../services/productService.dart';
import '../widget/productWidget.dart';
import '../widget/filterWidget.dart';
import '../helpers/share.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _filter = widgetControllerFilter;
  Products _products = new Products();
  Products _filteredProducts = new Products();
  String _searchText = "";
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text("StockTake App");

  @override
  void initState() {
    super.initState();
    Share.init();
    _products.products = new List();
    _filteredProducts.products = new List();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: _buildBar(context),
      drawer: buildDrawer(context),
      body: _buildList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => new ProductAdd()));
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(251, 165, 42, 1),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      elevation: 0.1,
      backgroundColor: colorBarApp,
      leading: new IconButton(
        icon: Icon(Icons.dehaze),
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
      ),
      centerTitle: true,
      title: _appBarTitle,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: _searchPressed,
        )
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    if (_searchText.isNotEmpty) {
      _filteredProducts.products = new List();
      for (int i = 0; i < _products.products.length; i++) {
        if (_products.products[i].title
                .toLowerCase()
                .contains(_searchText.toLowerCase()) ||
            _products.products[i].description
                .toLowerCase()
                .contains(_searchText.toLowerCase())) {
          _filteredProducts.products.add(_products.products[i]);
        }
      }
    }
    return ListView(
        padding: const EdgeInsets.only(top: 20.0),
        children: this
            ._filteredProducts
            .products
            .map((data) => _buildListItem(context, data))
            .toList());
  }

  Widget _buildListItem(BuildContext context, Product product) {
    return widgetListProducts(context, product);
  }

  _HomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          this._filteredProducts = resetCurentProductList(_products);
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  void getProducts() async {
    Products tempProducts = await apiGetProducts();
    setState(() {
      for (Product product in tempProducts.products) {
        this._products.products.add(product);
        this._filteredProducts.products.add(product);
      }
    });
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = getInputFilter(_filter);
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text("StockTake App");
        _filter.clear();
      }
    });
  }
}
