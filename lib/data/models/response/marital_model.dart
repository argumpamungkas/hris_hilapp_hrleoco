// To parse this JSON data, do
//
//     final maritalModel = maritalModelFromJson(jsonString);

import 'dart:convert';

MaritalModel maritalModelFromJson(String str) => MaritalModel.fromJson(json.decode(str));

String maritalModelToJson(MaritalModel data) => json.encode(data.toJson());

class MaritalModel {
  String? id;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? deleted;
  String? number;
  String? name;
  String? description;
  String? terType;
  String? status;

  MaritalModel({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.deleted,
    required this.number,
    required this.name,
    required this.description,
    required this.terType,
    required this.status,
  });

  factory MaritalModel.fromJson(Map<String, dynamic> json) => MaritalModel(
    id: json["id"] ?? "",
    createdBy: json["created_by"] ?? "",
    createdDate: json["created_date"] ?? "",
    updatedBy: json["updated_by"] ?? "",
    updatedDate: json["updated_date"] ?? "",
    deleted: json["deleted"] ?? "",
    number: json["number"] ?? "",
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    terType: json["ter_type"] ?? "",
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
    "ter_type": terType,
    "status": status,
  };

  static List<MaritalModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MaritalModel.fromJson(json)).toList();
  }
}
