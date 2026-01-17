import 'dart:convert';

EmployeeFamiliesModel employeeFamiliesFromJson(String str) => EmployeeFamiliesModel.fromJson(json.decode(str));

String employeeFamiliesToJson(EmployeeFamiliesModel data) => json.encode(data.toJson());

class EmployeeFamiliesModel {
  String id;
  String createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? deleted;
  String? number;
  String? nationalId;
  String? name;
  String? place;
  String? birthday;
  String? relation;
  String? profesion;
  String? contact;
  String? status;

  EmployeeFamiliesModel({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.deleted,
    required this.number,
    required this.nationalId,
    required this.name,
    required this.place,
    required this.birthday,
    required this.relation,
    required this.profesion,
    required this.contact,
    required this.status,
  });

  factory EmployeeFamiliesModel.fromJson(Map<String, dynamic> json) => EmployeeFamiliesModel(
    id: json["id"] ?? "",
    createdBy: json["created_by"] ?? "",
    createdDate: json["created_date"] ?? "",
    updatedBy: json["updated_by"] ?? "",
    updatedDate: json["updated_date"] ?? "",
    deleted: json["deleted"] ?? "",
    number: json["number"] ?? "",
    nationalId: json["national_id"] ?? "",
    name: json["name"] ?? "",
    place: json["place"] ?? "",
    birthday: json["birthday"] ?? "",
    relation: json["relation"] ?? "",
    profesion: json["profesion"] ?? "",
    contact: json["contact"] ?? "",
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
    "national_id": nationalId,
    "name": name,
    "place": place,
    "birthday": birthday,
    "relation": relation,
    "profesion": profesion,
    "contact": contact,
    "status": status,
  };
}
