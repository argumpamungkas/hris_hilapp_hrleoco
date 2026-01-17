class RegisterResponse {
  String? title;
  String? message;
  String? theme;
  RegisterResult? results;

  RegisterResponse({
    required this.title,
    required this.message,
    required this.theme,
    required this.results,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      title: json['title'],
      message: json['message'],
      theme: json['theme'],
      results: RegisterResult.fromJson(
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

class RegisterResult {
  String? link;
  String? apiKey;

  RegisterResult({
    required this.link,
    required this.apiKey,
  });

  factory RegisterResult.fromJson(Map<String, dynamic> json) => RegisterResult(
        link: json["link"],
        apiKey: json["api_key"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "api_key": apiKey,
      };
}
