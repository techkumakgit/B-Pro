class Status{
  Status({this.name, this.idInt});
  final String name;
   int idInt;
  factory Status.fromJson(Map<String, dynamic> json) =>
      Status(
        idInt: json["id"],
        name: json["status"],
      );
}