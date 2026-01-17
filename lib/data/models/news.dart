import 'package:intl/intl.dart';

import '../../ui/util/utils.dart';

class News {
  String title;
  String message;
  String theme;
  List<ResultsNews> results;

  News({required this.title, required this.message, required this.theme, required this.results});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      message: json['message'],
      theme: json['theme'],
      results: List<ResultsNews>.from(json['results'].map((x) => ResultsNews.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'message': message,
    'theme': theme,
    'results': List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class ResultsNews {
  String id;
  String avatar;
  String createdBy;
  String createdDate;
  String startDate;
  String finishDate;
  String name;
  String description;
  String attachment;

  ResultsNews({
    required this.id,
    required this.avatar,
    required this.createdBy,
    required this.createdDate,
    required this.startDate,
    required this.finishDate,
    required this.name,
    required this.description,
    required this.attachment,
  });

  factory ResultsNews.fromJson(Map<String, dynamic> json) {
    late String createdDateNews;
    if (json['created_date'] != null || json['created_date'] != "") {
      var dateFormatDefautlt = DateFormat("yyyy-MM-dd HH:mm:ss").parse(json['created_date']);
      createdDateNews = formatCreatedDate(dateFormatDefautlt);
    }
    return ResultsNews(
      id: json['id'],
      avatar: json['avatar'],
      createdBy: json['created_by'],
      createdDate: createdDateNews,
      startDate: json['start_date'],
      finishDate: json['finish_date'],
      name: json['name'],
      description: json['description'],
      attachment: json['attachment'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'avatar': avatar,
    'created_by': createdBy,
    'created_date': createdDate,
    'start_date': startDate,
    'finish_date': finishDate,
    'name': name,
    'description': description,
    'attachment': attachment,
  };
}
