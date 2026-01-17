class LocationOffice {
  String title;
  String message;
  String theme;
  List<ResultsLocationOffice> results;

  LocationOffice({
    required this.title,
    required this.message,
    required this.theme,
    required this.results,
  });

  factory LocationOffice.fromJson(Map<String, dynamic> json) => LocationOffice(
        title: json["title"],
        message: json["message"],
        theme: json["theme"],
        results: List<ResultsLocationOffice>.from(
          json['results'].map(
            (x) => ResultsLocationOffice.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "theme": theme,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class ResultsLocationOffice {
  String id;
  String? number;
  String? name;
  String? link;
  String? latitude;
  String? longitude;
  String? radius;
  String? group;
  String? status;

  ResultsLocationOffice({
    required this.id,
    required this.number,
    required this.name,
    required this.link,
    required this.latitude,
    required this.longitude,
    required this.radius,
    required this.group,
    required this.status,
  });

  factory ResultsLocationOffice.fromJson(Map<String, dynamic> json) =>
      ResultsLocationOffice(
        id: json["id"],
        number: json["number"],
        name: json["name"],
        link: json["link"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        radius: json["radius"],
        group: json["group"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "name": name,
        "link": link,
        "latitude": latitude,
        "longitude": longitude,
        "radius": radius,
        "group": group,
        "status": status,
      };
}
