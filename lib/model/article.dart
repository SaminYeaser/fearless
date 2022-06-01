import 'dart:convert';

ArticlesModel articlesFromJson(String str) => ArticlesModel.fromJson(json.decode(str));

String articlesToJson(ArticlesModel data) => json.encode(data.toJson());
class ArticlesModel {
  ArticlesModel({
    this.article,
    this.firstname,
    this.lastname,
  });

  String? article;
  String? firstname;
  String? lastname;

  factory ArticlesModel.fromJson(Map<String, dynamic> json) => ArticlesModel(
    article: json["article"],
    firstname: json["firstname"],
    lastname: json["lastname"],
  );

  Map<String, dynamic> toJson() => {
    "article": article,
    "firstname": firstname,
    "lastname": lastname,
  };
}
