import 'dart:convert';

DivisionModel divisionModelFromJson(String str) => DivisionModel.fromJson(json.decode(str));

String divisionModelToJson(DivisionModel data) => json.encode(data.toJson());

class DivisionModel {
  String? id;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? deleted;
  String? number;
  String? name;
  String? description;
  String? status;

  DivisionModel({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.deleted,
    required this.number,
    required this.name,
    required this.description,
    required this.status,
  });

  factory DivisionModel.fromJson(Map<String, dynamic> json) => DivisionModel(
    id: json["id"] ?? "",
    createdBy: json["created_by"] ?? "",
    createdDate: json["created_date"] ?? "",
    updatedBy: json["updated_by"] ?? "",
    updatedDate: json["updated_date"] ?? "",
    deleted: json["deleted"] ?? "",
    number: json["number"] ?? "",
    name: json["name"] ?? "",
    description: json["description"] ?? "",
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
    "status": status,
  };
}
