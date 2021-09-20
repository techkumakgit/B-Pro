import 'dart:convert';
class PhaseMember {
  int id;
  String name;
  bool isApproved;
  PhaseMember({
     this.id,
     this.name,
    this.isApproved,
  });
  factory PhaseMember.fromRawJson(String str) => PhaseMember.fromJson(json.decode(str));
  factory PhaseMember.fromJson(Map<String, dynamic> json) => PhaseMember(
    id: json["id"],
    name: json["name"],
    isApproved: json["is_approved"],
  );
}
