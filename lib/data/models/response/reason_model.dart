import 'dart:convert';

ReasonModel reasonModelFromJson(String str) => ReasonModel.fromJson(json.decode(str));

String reasonModelToJson(ReasonModel data) => json.encode(data.toJson());

class ReasonModel {
  String? id;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? deleted;
  String? permitTypeId;
  String? number;
  String? name;
  String? status;

  ReasonModel({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.deleted,
    required this.permitTypeId,
    required this.number,
    required this.name,
    required this.status,
  });

  factory ReasonModel.fromJson(Map<String, dynamic> json) => ReasonModel(
    id: json["id"] ?? "",
    createdBy: json["created_by"] ?? "",
    createdDate: json["created_date"] ?? "",
    updatedBy: json["updated_by"] ?? "",
    updatedDate: json["updated_date"] ?? "",
    deleted: json["deleted"] ?? "",
    permitTypeId: json["permit_type_id"] ?? "",
    number: json["number"] ?? "",
    name: json["name"] ?? "",
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_by": createdBy,
    "created_date": createdDate,
    "updated_by": updatedBy,
    "updated_date": updatedDate,
    "deleted": deleted,
    "permit_type_id": permitTypeId,
    "number": number,
    "name": name,
    "status": status,
  };

  static List<ReasonModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ReasonModel.fromJson(json)).toList();
  }
}
