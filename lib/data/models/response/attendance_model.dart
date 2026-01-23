import 'dart:convert';

AttendanceModel attendanceModelFromJson(String str) => AttendanceModel.fromJson(json.decode(str));

String attendanceModelToJson(AttendanceModel data) => json.encode(data.toJson());

class AttendanceModel {
  String id;
  String? createdBy;
  String? createdDate;
  String? number;
  String? transDate;
  String? transTime;
  String? location;
  String? source;
  String? foto;
  String? status;

  AttendanceModel({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.number,
    required this.transDate,
    required this.transTime,
    required this.location,
    required this.source,
    required this.foto,
    required this.status,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) => AttendanceModel(
    id: json["id"] ?? "",
    createdBy: json["created_by"] ?? "",
    createdDate: json["created_date"] ?? "",
    number: json["number"] ?? "",
    transDate: json["trans_date"] ?? "",
    transTime: json["trans_time"] ?? "",
    location: json["location"] ?? "",
    source: json["source"] ?? "",
    foto: json["foto"] ?? "",
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_by": createdBy,
    "created_date": createdDate,
    "number": number,
    "trans_date": transDate,
    "trans_time": transTime,
    "location": location,
    "source": source,
    "foto": foto,
    "status": status,
  };

  static List<AttendanceModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => AttendanceModel.fromJson(json)).toList();
  }
}
