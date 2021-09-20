import 'dart:convert';
import 'package:processmanagement/Model/Status.dart';
import 'Phase.dart';
class Process {
   int id;
   String title;
   String description;
   String startDate;
   String endDate;
   Status status;
   List<Phase> phase;

  Process({ this.id,    this.title,  this.status , this.startDate, this.endDate, this.description});

  factory Process.fromRawJson(String str) => Process.fromJson(json.decode(str));

  factory Process.fromJson(Map<String, dynamic> json) => Process(
    id: json["id"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    description: json["description"],
    title: json["title"],
    status: Status.fromJson(json["status"]),

  );
}
