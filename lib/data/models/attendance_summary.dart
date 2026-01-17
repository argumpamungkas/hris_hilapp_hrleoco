class AttendanceSummary {
  int? working;
  int? permit;
  int? absence;
  int? notYet;
  int? late;
  List<ResultAttendanceSummary> details;

  AttendanceSummary({
    required this.working,
    required this.permit,
    required this.absence,
    required this.notYet,
    required this.late,
    required this.details,
  });

  factory AttendanceSummary.fromJson(Map<String, dynamic> json) =>
      AttendanceSummary(
        working: json['working'] ?? 0,
        permit: json['permit'] ?? 0,
        absence: json['absence'] ?? 0,
        notYet: json['notyet'] ?? 0,
        late: json['late'] ?? 0,
        details: List<ResultAttendanceSummary>.from(
          json['details'].map(
            (x) => ResultAttendanceSummary.fromJson(x),
          ),
        ).toList(),
      );

  Map<String, dynamic> toJson() => {
        'working': working,
        'permit': permit,
        'absence': absence,
        'notyet': notYet,
        'late': late,
        'details': List<dynamic>.from(details.map((x) => x.toJson()))
      };
}

class ResultAttendanceSummary {
  String transDate;
  String? timeIn;
  String? timeOut;
  String status;
  String color;
  String? remarks;

  ResultAttendanceSummary({
    required this.transDate,
    required this.timeIn,
    required this.timeOut,
    required this.status,
    required this.color,
    required this.remarks,
  });

  factory ResultAttendanceSummary.fromJson(Map<String, dynamic> json) =>
      ResultAttendanceSummary(
        transDate: json['trans_date'],
        timeIn: json['time_in'] ?? "-",
        timeOut: json['time_out'] ?? "-",
        status: json['status'],
        color: json['color'],
        remarks: json['remarks'] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        'trans_date': transDate,
        'time_in': timeIn,
        'time_out': timeOut,
        'status': status,
        'color': color,
        'remarks': remarks,
      };
}
