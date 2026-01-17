class ApiResponse<T> {
  ApiResponse({this.title, this.message, this.result, this.theme, required this.onSerialized, required this.onDeserialized});

  String? title;
  String? message;
  T? result;
  String? theme;
  late dynamic Function(T) onSerialized;
  late T Function(dynamic) onDeserialized;

  ApiResponse.fromJson(Map<String, dynamic> json, {required dynamic Function(T) onDataSerialized, required T Function(dynamic) onDataDeserialized}) {
    onSerialized = onDataSerialized;
    onDeserialized = onDataDeserialized;
    title = json['title'];
    message = json['message'];
    theme = json['theme'];
    result = json['result'] != null ? onDeserialized(json['result']) : null;
  }

  Map<String, dynamic> toJson() => {"title": title, "message": message, "theme": theme, "result": result != null ? onSerialized(result as T) : null};
}
