class ResponseInfo {
  String title;
  String message;
  String theme;

  ResponseInfo({
    required this.title,
    required this.message,
    required this.theme,
  });

  factory ResponseInfo.fromJson(Map<String, dynamic> json) {
    return ResponseInfo(
      title: json['title'],
      message: json['message'],
      theme: json['theme'],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "theme": theme,
      };
}
