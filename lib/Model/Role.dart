import 'dart:convert';
class Role {
  final int id;
  final String name;
  Role({
    this.id,
    this.name,
  });
  factory Role.fromRawJson(String str) => Role.fromJson(json.decode(str));
  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
      );
}
