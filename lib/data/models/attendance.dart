class Attendance {
  String title;
  String message;
  String theme;
  ResultsAttendance results;

  Attendance({
    required this.title,
    required this.message,
    required this.theme,
    required this.results,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      title: json['title'],
      message: json['message'],
      theme: json['theme'],
      results: ResultsAttendance.fromJson(json['results']),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'message': message,
        'theme': theme,
        'results': results.toJson(),
      };
}

class ResultsAttendance {
  String? start;
  String? end;
  String? shiftName;
  String? shiftDetail;
  String? dateIn;
  String? dateOut;
  String? timeIn;
  String? timeOut;

  ResultsAttendance({
    required this.start,
    required this.end,
    required this.shiftName,
    required this.shiftDetail,
    required this.dateIn,
    required this.dateOut,
    required this.timeIn,
    required this.timeOut,
  });

  factory ResultsAttendance.fromJson(Map<String, dynamic> json) {
    return ResultsAttendance(
      start: json['start'],
      end: json['end'],
      shiftName: json['shift_name'],
      shiftDetail: json['shift_detail'],
      dateIn: json['date_in'],
      dateOut: json['date_out'],
      timeIn: json['time_in'],
      timeOut: json['time_out'],
    );
  }

  Map<String, dynamic> toJson() => {
        'start': start,
        'end': end,
        'shift_name': shiftName,
        'shift_detail': shiftDetail,
        'date_in': dateIn,
        'date_out': dateOut,
        'time_in': timeIn,
        'time_out': timeOut,
      };
}
