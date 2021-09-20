import 'dart:convert';
import 'package:processmanagement/Model/Stage.dart';
import 'package:processmanagement/Model/Status.dart';
import 'PhaseMember.dart';
class Phase {
  int id;
  int documentCount;
  int processNameId;
  String title;
  String description;
  String startDate;
  String startTime;
  String endDate;
  String endTime;
  List<PhaseMember> phaseMember;
  Status status;
  Stage stage;

  Phase({
    this.startDate,
    this.description,
    this.startTime,
    this.endTime,
    this.endDate,
     this.id,
     this.processNameId,
     this.title,
     this.status,
     this.stage,
     this.documentCount
  });

  factory Phase.fromRawJson(String str) => Phase.fromJson(json.decode(str));

  factory Phase.fromJson(Map<String, dynamic> json) => Phase(
    id: json["id"],
    endDate: json["end_date"],
    startDate: json["start_date"],
    processNameId: json["process_name_id"],
    documentCount: json["document_count"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    description: json["description"],
    title: json["title"],
    status: Status.fromJson(json["status"]),
    stage: Stage.fromJson(json["stage_type"]),

  );

}

