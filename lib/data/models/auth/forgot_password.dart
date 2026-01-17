class ForgotPasswordResponse {
  String? title;
  String? message;
  String? theme;
  ForgotPasswordResults? results;

  ForgotPasswordResponse({
    required this.title,
    required this.message,
    required this.theme,
    required this.results,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      title: json['title'],
      message: json['message'],
      theme: json['theme'],
      results: ForgotPasswordResults.fromJson(
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

class ForgotPasswordResults {
  String? newPassword;

  ForgotPasswordResults({
    required this.newPassword,
  });

  factory ForgotPasswordResults.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResults(
        newPassword: json["new_password"],
      );

  Map<String, dynamic> toJson() => {
        "new_password": newPassword,
      };
}
