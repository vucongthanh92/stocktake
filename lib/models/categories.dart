import 'category.dart';

class Categories {
  List<Category> categories = new List();

  Categories({
    this.categories
  });

  factory Categories.fromJson(List<dynamic> parsedJson) {
    List<Category> categories = new List<Category>();
    categories = parsedJson.map((i) => Category.fromJson(i)).toList();
    return new Categories(
      categories: categories
    );
  }
}