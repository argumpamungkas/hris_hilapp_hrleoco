class CompanyResponse {
  String? title;
  String? message;
  String? theme;
  CompanyResults? results;

  CompanyResponse({
    required this.title,
    required this.message,
    required this.theme,
    required this.results,
  });

  factory CompanyResponse.fromJson(Map<String, dynamic> json) {
    return CompanyResponse(
      title: json['title'],
      message: json['message'],
      theme: json['theme'],
      results: CompanyResults.fromJson(
        json['results'],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "theme": theme,
        "results": results!.toJson(),
      };
}

class CompanyResults {
  String? number;
  String? name;
  String? link;
  String? status;

  CompanyResults({
    required this.number,
    required this.name,
    required this.link,
    required this.status,
  });

  factory CompanyResults.fromJson(Map<String, dynamic> json) => CompanyResults(
        number: json['number'],
        name: json['name'],
        link: json["link"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "link": link,
        "status": status,
      };
}
