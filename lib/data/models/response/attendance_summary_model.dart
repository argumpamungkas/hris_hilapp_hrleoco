class AttendanceSummaryModel {
  int? working;
  int? permit;
  int? absence;
  int? notyet;
  int? late;
  List<DetailAttendanceSummary> details;

  AttendanceSummaryModel({
    required this.working,
    required this.permit,
    required this.absence,
    required this.notyet,
    required this.late,
    required this.details,
  });

  factory AttendanceSummaryModel.fromJson(Map<String, dynamic> json) => AttendanceSummaryModel(
    working: json["working"] ?? 0,
    permit: json["permit"] ?? 0,
    absence: json["absence"] ?? 0,
    notyet: json["notyet"] ?? 0,
    late: json["late"] ?? 0,
    details: List<DetailAttendanceSummary>.from(json["details"].map((x) => DetailAttendanceSummary.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "working": working,
    "permit": permit,
    "absence": absence,
    "notyet": notyet,
    "late": late,
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class DetailAttendanceSummary {
  String? transDate;
  String? shiftName;
  String? checkIn;
  String? checkOut;
  String? status;
  String? remarks;
  String? color;

  DetailAttendanceSummary({
    required this.transDate,
    required this.shiftName,
    required this.checkIn,
    required this.checkOut,
    required this.status,
    required this.remarks,
    required this.color,
  });

  factory DetailAttendanceSummary.fromJson(Map<String, dynamic> json) => DetailAttendanceSummary(
    transDate: json["trans_date"] ?? '',
    shiftName: json["shift_name"] ?? '',
    checkIn: json["check_in"] ?? '',
    checkOut: json["check_out"] ?? '',
    status: json["status"] ?? '',
    remarks: json["remarks"] ?? '',
    color: json["color"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "trans_date": transDate,
    "shift_name": shiftName,
    "check_in": checkIn,
    "check_out": checkOut,
    "status": status,
    "remarks": remarks,
    "color": color,
  };
}
