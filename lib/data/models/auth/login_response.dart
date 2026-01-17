class LoginResponse {
  String? title;
  String? message;
  String? theme;
  LoginResults? results;

  LoginResponse({
    required this.title,
    required this.message,
    required this.theme,
    required this.results,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      title: json['title'],
      message: json['message'],
      theme: json['theme'],
      results: LoginResults.fromJson(
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

class LoginResults {
  String? link;
  String? apiKey;

  LoginResults({
    required this.link,
    required this.apiKey,
  });

  factory LoginResults.fromJson(Map<String, dynamic> json) => LoginResults(
        link: json["link"],
        apiKey: json["api_key"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "api_key": apiKey,
      };
}
