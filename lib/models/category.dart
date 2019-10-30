class Category {
  int sid;
  String title;
  String description;
  int parentID;
  int status;
  int createdby;

  Category({
    this.sid,
    this.title,
    this.description,
    this.parentID,
    this.status,
    this.createdby
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return new Category(
      sid: int.parse(json['SID'].toString()),
      title: json['Title'].toString(),
      description: json['Description'].toString(),
      parentID: int.parse(json["ParentID"].toString()),
      status: int.parse(json["Status"].toString()),
      createdby: int.parse(json['Createdby'].toString()),
    );
  }
}
