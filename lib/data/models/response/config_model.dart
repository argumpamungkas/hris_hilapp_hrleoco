// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

ConfigModel configModelFromJson(String str) => ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
  String? id;
  String? createdBy;
  DateTime createdDate;
  String? updatedBy;
  String? updatedDate;
  String? deleted;
  String? number;
  String? name;
  String? description;
  String? businessField;
  String? address;
  String? city;
  String? postalCode;
  String? telp;
  String? fax;
  String? email;
  String? website;
  String? npwp;
  String? latitude;
  String? longitude;
  String? radius;
  String? logo;
  String? favicon;
  String? image;
  String? theme;
  String? token;
  String? idcardStatus;
  String? empDateStart;
  String? empDateEnd;
  String? status;

  ConfigModel({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.deleted,
    required this.number,
    required this.name,
    required this.description,
    required this.businessField,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.telp,
    required this.fax,
    required this.email,
    required this.website,
    required this.npwp,
    required this.latitude,
    required this.longitude,
    required this.radius,
    required this.logo,
    required this.favicon,
    required this.image,
    required this.theme,
    required this.token,
    required this.idcardStatus,
    required this.empDateStart,
    required this.empDateEnd,
    required this.status,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
    id: json["id"] ?? '',
    createdBy: json["created_by"] ?? '',
    createdDate: DateTime.parse(json["created_date"]),
    updatedBy: json["updated_by"] ?? '',
    updatedDate: json["updated_date"] ?? '',
    deleted: json["deleted"] ?? '',
    number: json["number"] ?? '',
    name: json["name"] ?? '',
    description: json["description"] ?? '',
    businessField: json["business_field"] ?? '',
    address: json["address"] ?? '',
    city: json["city"] ?? '',
    postalCode: json["postal_code"] ?? '',
    telp: json["telp"] ?? '',
    fax: json["fax"] ?? '',
    email: json["email"] ?? '',
    website: json["website"] ?? '',
    npwp: json["npwp"] ?? '',
    latitude: json["latitude"] ?? '',
    longitude: json["longitude"] ?? '',
    radius: json["radius"] ?? '',
    logo: json["logo"] ?? '',
    favicon: json["favicon"] ?? '',
    image: json["image"] ?? '',
    theme: json["theme"] ?? '',
    token: json["token"] ?? '',
    idcardStatus: json["idcard_status"] ?? '',
    empDateStart: json["emp_date_start"] ?? '',
    empDateEnd: json["emp_date_end"] ?? '',
    status: json["status"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_by": createdBy,
    "created_date": createdDate.toIso8601String(),
    "updated_by": updatedBy,
    "updated_date": updatedDate,
    "deleted": deleted,
    "number": number,
    "name": name,
    "description": description,
    "business_field": businessField,
    "address": address,
    "city": city,
    "postal_code": postalCode,
    "telp": telp,
    "fax": fax,
    "email": email,
    "website": website,
    "npwp": npwp,
    "latitude": latitude,
    "longitude": longitude,
    "radius": radius,
    "logo": logo,
    "favicon": favicon,
    "image": image,
    "theme": theme,
    "token": token,
    "idcard_status": idcardStatus,
    "emp_date_start": empDateStart,
    "emp_date_end": empDateEnd,
    "status": status,
  };
}
