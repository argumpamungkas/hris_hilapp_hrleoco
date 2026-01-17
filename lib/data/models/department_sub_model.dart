import 'dart:convert';

DepartmentSubModel departmentSubModelFromJson(String str) => DepartmentSubModel.fromJson(json.decode(str));

String departmentSubModelToJson(DepartmentSubModel data) => json.encode(data.toJson());

class DepartmentSubModel {
  String? id;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? deleted;
  String? divisionId;
  String? departmentId;
  String? number;
  String? name;
  String? description;
  String? type;
  String? status;

  DepartmentSubModel({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.deleted,
    required this.divisionId,
    required this.departmentId,
    required this.number,
    required this.name,
    required this.description,
    required this.type,
    required this.status,
  });

  factory DepartmentSubModel.fromJson(Map<String, dynamic> json) => DepartmentSubModel(
    id: json["id"] ?? "",
    createdBy: json["created_by"] ?? "",
    createdDate: json["created_date"] ?? "",
    updatedBy: json["updated_by"] ?? "",
    updatedDate: json["updated_date"] ?? "",
    deleted: json["deleted"] ?? "",
    divisionId: json["division_id"] ?? "",
    departmentId: json["departement_id"] ?? "",
    number: json["number"] ?? "",
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    type: json["type"] ?? "",
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_by": createdBy,
    "created_date": createdDate,
    "updated_by": updatedBy,
    "updated_date": updatedDate,
    "deleted": deleted,
    "division_id": divisionId,
    "departement_id": departmentId,
    "number": number,
    "name": name,
    "description": description,
    "type": type,
    "status": status,
  };
}
