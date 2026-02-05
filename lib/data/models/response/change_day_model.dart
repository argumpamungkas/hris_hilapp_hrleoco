// To parse this JSON data, do
//
//     final changeDayModel = changeDayModelFromJson(jsonString);

import 'dart:convert';

ChangeDayModel changeDayModelFromJson(String str) => ChangeDayModel.fromJson(json.decode(str));

String changeDayModelToJson(ChangeDayModel data) => json.encode(data.toJson());

class ChangeDayModel {
  String? id;
  String? createdBy;
  DateTime? createdDate;
  String? approvedTo;
  String? approvedBy;
  String? approvedDate;
  String? employeeNumber;
  String? employeeName;
  String? requestCode;
  String? start;
  String? end;
  String? remarks;

  ChangeDayModel({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.approvedTo,
    required this.approvedBy,
    required this.approvedDate,
    required this.employeeNumber,
    required this.employeeName,
    required this.requestCode,
    required this.start,
    required this.end,
    required this.remarks,
  });

  factory ChangeDayModel.fromJson(Map<String, dynamic> json) => ChangeDayModel(
    id: json["id"] ?? '',
    createdBy: json["created_by"] ?? '',
    createdDate: DateTime.parse(json["created_date"]),
    approvedTo: json["approved_to"] ?? '',
    approvedBy: json["approved_by"] ?? '',
    approvedDate: json["approved_date"] ?? '',
    employeeNumber: json["employee_number"] ?? '',
    employeeName: json["employee_name"] ?? '',
    requestCode: json["request_code"] ?? '',
    start: json["start"] ?? '',
    end: json["end"] ?? '',
    remarks: json["remarks"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_by": createdBy,
    "created_date": createdDate?.toIso8601String(),
    "approved_to": approvedTo,
    "approved_by": approvedBy,
    "approved_date": approvedDate,
    "employee_number": employeeNumber,
    "employee_name": employeeName,
    "request_code": requestCode,
    "start": start,
    "end": end,
    "remarks": remarks,
  };

  static List<ChangeDayModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ChangeDayModel.fromJson(json)).toList();
  }
}
