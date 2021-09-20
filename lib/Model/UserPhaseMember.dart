import 'dart:convert';
class UserPhaseMember {
  int id;
  String name;
  UserPhaseMember({
    this.id,
    this.name,
  });
  factory UserPhaseMember.fromRawJson(String str) => UserPhaseMember.fromJson(json.decode(str));
  factory UserPhaseMember.fromJson(Map<String, dynamic> json) => UserPhaseMember(
    id: json["id"],
    name: json["name"],
  );
}
