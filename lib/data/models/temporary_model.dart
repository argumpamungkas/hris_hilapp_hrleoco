// To parse this JSON data, do
//
//     final temporaryModel = temporaryModelFromJson(jsonString);

import 'dart:convert';

TemporaryModel temporaryModelFromJson(String str) => TemporaryModel.fromJson(json.decode(str));

String temporaryModelToJson(TemporaryModel data) => json.encode(data.toJson());

class TemporaryModel {
  String? id;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? approved;
  String? approvedTo;
  String? approvedBy;
  String? approvedDate;
  // String approvedData;
  String? deleted;
  String? tableId;
  String? tableName;
  String? action;
  // String description;
  String? status;

  TemporaryModel({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.approved,
    required this.approvedTo,
    required this.approvedBy,
    required this.approvedDate,
    // required this.approvedData,
    required this.deleted,
    required this.tableId,
    required this.tableName,
    required this.action,
    // required this.description,
    required this.status,
  });

  factory TemporaryModel.fromJson(Map<String, dynamic> json) => TemporaryModel(
    id: json["id"] ?? "",
    createdBy: json["created_by"] ?? "",
    createdDate: json["created_date"] ?? "",
    updatedBy: json["updated_by"] ?? "",
    updatedDate: json["updated_date"] ?? "",
    approved: json["approved"] ?? "",
    approvedTo: json["approved_to"] ?? "",
    approvedBy: json["approved_by"] ?? "",
    approvedDate: json["approved_date"] ?? "",
    // approvedData: json["approved_data"] ?? "",
    deleted: json["deleted"] ?? "",
    tableId: json["table_id"] ?? "",
    tableName: json["table_name"] ?? "",
    action: json["action"] ?? "",
    // description: json["description"] ?? "",
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_by": createdBy,
    "created_date": createdDate,
    "updated_by": updatedBy,
    "updated_date": updatedDate,
    "approved": approved,
    "approved_to": approvedTo,
    "approved_by": approvedBy,
    "approved_date": approvedDate,
    // "approved_data": approvedData,
    "deleted": deleted,
    "table_id": tableId,
    "table_name": tableName,
    "action": action,
    // "description": description,
    "status": status,
  };
}
