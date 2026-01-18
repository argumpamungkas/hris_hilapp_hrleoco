// To parse this JSON data, do
//
//     final groupModel = groupModelFromJson(jsonString);

import 'dart:convert';

GroupModel groupModelFromJson(String str) => GroupModel.fromJson(json.decode(str));

String groupModelToJson(GroupModel data) => json.encode(data.toJson());

class GroupModel {
  String? id;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? deleted;
  String? number;
  String? name;
  String? description;
  String? source;
  String? overtime;
  String? status;

  GroupModel({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.deleted,
    required this.number,
    required this.name,
    required this.description,
    required this.source,
    required this.overtime,
    required this.status,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
    id: json["id"] ?? "",
    createdBy: json["created_by"] ?? "",
    createdDate: json["created_date"] ?? "",
    updatedBy: json["updated_by"] ?? "",
    updatedDate: json["updated_date"] ?? "",
    deleted: json["deleted"] ?? "",
    number: json["number"] ?? "",
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    source: json["source"] ?? "",
    overtime: json["overtime"] ?? "",
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
    "source": source,
    "overtime": overtime,
    "status": status,
  };
}
