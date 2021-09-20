import 'dart:convert';
class StageList {
  int id;
  String userName;
  bool isChecked = false;
  StageList({ this.id,  this.userName,  this.isChecked});
  factory StageList.fromRawJson(String str) => StageList.fromJson(json.decode(str));
  factory StageList.fromJson(Map<String, dynamic> json) => StageList(
    id: json["id"],
    userName: json["name"],
    isChecked: false,
  );
}
