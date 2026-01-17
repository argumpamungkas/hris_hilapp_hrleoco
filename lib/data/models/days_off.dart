class DaysOff {
  String title;
  String message;
  String theme;
  List<ResultsDaysOff> results;

  DaysOff({
    required this.title,
    required this.message,
    required this.theme,
    required this.results,
  });

  factory DaysOff.fromJson(Map<String, dynamic> json) {
    return DaysOff(
      title: json['title'],
      message: json['message'],
      theme: json['theme'],
      results: List<ResultsDaysOff>.from(
        json['results'].map(
          (x) => ResultsDaysOff.fromJson(x),
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

class ResultsDaysOff {
  String image;
  String name;
  String? timeIn;
  String? timeOut;
  String description;
  String employeeId;
  String services;
  String dateSign;
  String color;

  ResultsDaysOff({
    required this.image,
    required this.name,
    required this.timeIn,
    required this.timeOut,
    required this.description,
    required this.employeeId,
    required this.services,
    required this.dateSign,
    required this.color,
  });

  factory ResultsDaysOff.fromJson(Map<String, dynamic> json) {
    return ResultsDaysOff(
      image: json['image'],
      name: json['name'],
      timeIn: json['time_in'] ?? "-",
      timeOut: json['time_out'] ?? "-",
      description: json['description'],
      employeeId: json['employee_id'],
      services: json['services'],
      dateSign: json['date_sign'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "time_in": timeIn,
        "time_out": timeOut,
        "description": description,
        "employee_id": employeeId,
        "services": services,
        "date_sign": dateSign,
        "color": color,
      };
}
