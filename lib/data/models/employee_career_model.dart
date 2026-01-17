// To parse this JSON data, do
//
//     final employeeCareerModel = employeeCareerModelFromJson(jsonString);

import 'dart:convert';

class EmployeeCareerModel {
  String? id;
  String? start;
  String? division;
  String? name;
  String? description;
  String? contact;
  String? profesion;

  EmployeeCareerModel({
    required this.id,
    required this.start,
    required this.division,
    required this.name,
    required this.description,
    required this.contact,
    required this.profesion,
  });

  factory EmployeeCareerModel.fromJson(Map<String, dynamic> json) => EmployeeCareerModel(
    id: json["id"] ?? "",
    start: json["start"] ?? "",
    division: json["division"] ?? "",
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    contact: json["contact"] ?? "",
    profesion: json["profesion"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "ids": id,
    "start": start,
    "division": division,
    "name": name,
    "description": description,
    "contact": contact,
    "profesion": profesion,
  };
}
