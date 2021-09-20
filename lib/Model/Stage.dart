import 'dart:convert';
class Stage {
  int id;
  String name;
  Stage({
    this.id,
    this.name,
  });
  factory Stage.fromRawJson(String str) => Stage.fromJson(json.decode(str));
  factory Stage.fromJson(Map<String, dynamic> json) => Stage(
        id: json["id"],
        name: json["name"],
      );
}
