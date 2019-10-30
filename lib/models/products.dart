import 'product.dart';

class Products {
  List<Product> products = new List();

  Products({
    this.products
  });

  factory Products.fromJson(List<dynamic> parsedJson) {
    List<Product> products = new List<Product>();
    products = parsedJson.map((i) => Product.fromJson(i)).toList();
    return new Products(
      products: products
    );
  }
}