class ConfigModel {
  String? id;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? deleted;
  String? number;
  String? name;
  String? description;
  String? address;
  String? city;
  String? npwp;
  String? latitude;
  String? longitude;
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
    required this.address,
    required this.city,
    required this.npwp,
    required this.latitude,
    required this.longitude,
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
    id: json["id"] ?? "",
    createdBy: json["created_by"] ?? "",
    createdDate: json["created_date"] ?? "",
    updatedBy: json["updated_by"] ?? "",
    updatedDate: json["updated_date"] ?? "",
    deleted: json["deleted"] ?? "",
    number: json["number"] ?? "",
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    address: json["address"] ?? "",
    city: json["city"] ?? "",
    npwp: json["npwp"] ?? "",
    latitude: json["latitude"] ?? "",
    longitude: json["longitude"] ?? "",
    logo: json["logo"] ?? "",
    favicon: json["favicon"] ?? "",
    image: json["image"] ?? "",
    theme: json["theme"] ?? "",
    token: json["token"] ?? "",
    idcardStatus: json["idcard_status"] ?? "",
    empDateStart: json["emp_date_start"] ?? "",
    empDateEnd: json["emp_date_end"] ?? "",
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
    "address": address,
    "city": city,
    "npwp": npwp,
    "latitude": latitude,
    "longitude": longitude,
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
