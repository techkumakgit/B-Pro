import 'dart:convert';
class User {
  int id;
  String userName;
  bool isChecked = false;
  User({ this.id,  this.userName,  this.isChecked});
  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userName: json["name"],
        isChecked: false,
      );
}
