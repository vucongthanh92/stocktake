class User {
  int sid;
  String username;
  String fullname;
  int roleID;
  String rolename;

  User({
    this.sid,
    this.username,
    this.fullname,
    this.roleID,
    this.rolename
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
      sid: int.parse(json['SID'].toString()),
      username: json['UserName'].toString(),
      fullname: json['Fullname'].toString(),
      roleID: int.parse(json['RoleID'].toString()),
      rolename: json['RoleName'],
    );
  }
}