class Product {
  int sid;
  String title;
  String description;
  int categoryID;
  Map category;
  String images;
  double price;
  int quantity;
  int status;
  int createdby;

  Product({
    this.sid,
    this.title,
    this.description,
    this.categoryID,
    this.category,
    this.images,
    this.price,
    this.quantity,
    this.status,
    this.createdby
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product(
      sid: int.parse(json['SID'].toString()),
      title: json['Title'].toString(),
      description: json['Description'].toString(),
      categoryID: int.parse(json['CategoryID'].toString()),
      category: json['Category'],
      images: json['Images'].toString(),
      price: double.parse(json['Price'].toString()),
      quantity: int.parse(json['Quantity'].toString()),
      status: int.parse(json['Status'].toString()),
      createdby: int.parse(json['Createdby'].toString()),
    );
  }
}
