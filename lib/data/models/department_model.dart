import 'dart:convert';

DepartmentModel departmentModelFromJson(String str) => DepartmentModel.fromJson(json.decode(str));

String departmentModelToJson(DepartmentModel data) => json.encode(data.toJson());

class DepartmentModel {
  String? id;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? deleted;
  String? divisionId;
  String? number;
  String? numberId;
  String? name;
  String? description;
  String? status;

  DepartmentModel({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.deleted,
    required this.divisionId,
    required this.number,
    required this.numberId,
    required this.name,
    required this.description,
    required this.status,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) => DepartmentModel(
    id: json["id"] ?? "",
    createdBy: json["created_by"] ?? "",
    createdDate: json["created_date"] ?? "",
    updatedBy: json["updated_by"] ?? "",
    updatedDate: json["updated_date"] ?? "",
    deleted: json["deleted"] ?? "",
    divisionId: json["division_id"] ?? "",
    number: json["number"] ?? "",
    numberId: json["number_id"] ?? "",
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
    "division_id": divisionId,
    "number": number,
    "number_id": numberId,
    "name": name,
    "description": description,
    "status": status,
  };
}
