class HistoryAttendance {
  String title;
  String message;
  String theme;
  List<ResultsHistoryAttendance> results;

  HistoryAttendance({
    required this.title,
    required this.message,
    required this.theme,
    required this.results,
  });

  factory HistoryAttendance.fromJson(Map<String, dynamic> json) {
    return HistoryAttendance(
      title: json['title'],
      message: json['message'],
      theme: json['theme'],
      results: List<ResultsHistoryAttendance>.from(
        json['results'].map(
          (x) => ResultsHistoryAttendance.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'message': message,
        'theme': theme,
        'results': List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class ResultsHistoryAttendance {
  String? dateIn;
  String? dateOut;
  String? timeIn;
  String? timeOut;
  String? fotoIn;
  String? fotoOut;

  ResultsHistoryAttendance({
    required this.dateIn,
    required this.dateOut,
    required this.timeIn,
    required this.timeOut,
    required this.fotoIn,
    required this.fotoOut,
  });

  factory ResultsHistoryAttendance.fromJson(Map<String, dynamic> json) {
    return ResultsHistoryAttendance(
      dateIn: json['date_in'],
      dateOut: json['date_out'],
      timeIn: json['time_in'],
      timeOut: json['time_out'],
      fotoIn: json['foto_in'],
      fotoOut: json['foto_out'],
    );
  }

  Map<String, dynamic> toJson() => {
        "date_in": dateIn,
        "date_out": dateOut,
        "time_in": timeIn,
        "time_out": timeOut,
        "foto_in": fotoIn,
        "foto_out": fotoOut,
      };
}
