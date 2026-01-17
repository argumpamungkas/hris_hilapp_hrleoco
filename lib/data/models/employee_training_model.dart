// To parse this JSON data, do
//
//     final employeeTrainingModel = employeeTrainingModelFromJson(jsonString);

import 'dart:convert';

EmployeeTrainingModel employeeTrainingModelFromJson(String str) => EmployeeTrainingModel.fromJson(json.decode(str));

String employeeTrainingModelToJson(EmployeeTrainingModel data) => json.encode(data.toJson());

class EmployeeTrainingModel {
  String? id;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? deleted;
  String? number;
  String? name;
  String? description;
  String? start;
  String? profesion;
  String? contact;
  String? status;

  EmployeeTrainingModel({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.deleted,
    required this.number,
    required this.name,
    required this.description,
    required this.start,
    required this.profesion,
    required this.contact,
    required this.status,
  });

  factory EmployeeTrainingModel.fromJson(Map<String, dynamic> json) => EmployeeTrainingModel(
    id: json["id"] ?? "",
    createdBy: json["created_by"] ?? "",
    createdDate: json["created_date"] ?? "",
    updatedBy: json["updated_by"] ?? "",
    updatedDate: json["updated_date"] ?? "",
    deleted: json["deleted"] ?? "",
    number: json["number"] ?? "",
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    start: json["start"] ?? "",
    profesion: json["profesion"] ?? "",
    contact: json["contact"] ?? "",
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
    "description": description,
    "start": start,
    "profesion": profesion,
    "contact": contact,
    "status": status,
  };
}
