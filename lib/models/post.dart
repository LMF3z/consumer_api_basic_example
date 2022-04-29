import 'dart:convert';

List<JsonPlaceH> jsonPlaceHFromJson(String str) =>
    List<JsonPlaceH>.from(json.decode(str).map((x) => JsonPlaceH.fromJson(x)));

String jsonPlaceHToJson(List<JsonPlaceH> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JsonPlaceH {
  int? userId;
  int? id;
  String? title;
  String? body;

  JsonPlaceH({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory JsonPlaceH.fromJson(Map<String, dynamic> json) => JsonPlaceH(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
