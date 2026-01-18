import 'dart:convert';

EmployeeEducationModel employeeEducationFromJson(String str) => EmployeeEducationModel.fromJson(json.decode(str));

String employeeEducationToJson(EmployeeEducationModel data) => json.encode(data.toJson());

class EmployeeEducationModel {
  String? id;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? deleted;
  String? number;
  String? level;
  String? degree;
  String? school;
  String? start;
  String? end;
  String? qpa;
  String? status;

  EmployeeEducationModel({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.deleted,
    required this.number,
    required this.level,
    required this.degree,
    required this.school,
    required this.start,
    required this.end,
    required this.qpa,
    required this.status,
  });

  factory EmployeeEducationModel.fromJson(Map<String, dynamic> json) => EmployeeEducationModel(
    id: json["id"] ?? "",
    createdBy: json["created_by"] ?? "",
    createdDate: json["created_date"] ?? "",
    updatedBy: json["updated_by"] ?? "",
    updatedDate: json["updated_date"] ?? "",
    deleted: json["deleted"] ?? "",
    number: json["number"] ?? "",
    level: json["level"] ?? "",
    degree: json["degree"] ?? "",
    school: json["school"] ?? "",
    start: json["start"] ?? "",
    end: json["end"] ?? "",
    qpa: json["qpa"] ?? "",
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
    "level": level,
    "degree": degree,
    "school": school,
    "start": start,
    "end": end,
    "qpa": qpa,
    "status": status,
  };
}
