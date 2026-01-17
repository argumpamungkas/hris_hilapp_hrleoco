// To parse this JSON data, do
//
//     final employeeExperienceModel = employeeExperienceModelFromJson(jsonString);

import 'dart:convert';

EmployeeExperienceModel employeeExperienceModelFromJson(String str) => EmployeeExperienceModel.fromJson(json.decode(str));

String employeeExperienceModelToJson(EmployeeExperienceModel data) => json.encode(data.toJson());

class EmployeeExperienceModel {
  String? id;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? deleted;
  String? number;
  String? name;
  String? type;
  String? start;
  String? end;
  String? position;
  String? salary;
  String? status;

  EmployeeExperienceModel({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.deleted,
    required this.number,
    required this.name,
    required this.type,
    required this.start,
    required this.end,
    required this.position,
    required this.salary,
    required this.status,
  });

  factory EmployeeExperienceModel.fromJson(Map<String, dynamic> json) => EmployeeExperienceModel(
    id: json["id"] ?? "",
    createdBy: json["created_by"] ?? "",
    createdDate: json["created_date"] ?? "",
    updatedBy: json["updated_by"] ?? "",
    updatedDate: json["updated_date"] ?? "",
    deleted: json["deleted"] ?? "",
    number: json["number"] ?? "",
    name: json["name"] ?? "",
    type: json["type"] ?? "",
    start: json["start"] ?? "",
    end: json["end"] ?? "",
    position: json["position"] ?? "",
    salary: json["salary"] ?? "",
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_by": createdBy,
    "created_date": createdDate,
    "updated_by": updatedBy,
    "updated_date": updatedDate,
    "deleted": deleted,
    "number": number,
    "name": name,
    "type": type,
    "start": start,
    "end": end,
    "position": position,
    "salary": salary,
    "status": status,
  };
}
