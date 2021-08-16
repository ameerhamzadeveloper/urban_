// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

Categories categoriesFromJson(String str) =>
    Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  Categories({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<SericeCategories>? data;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        status: json["status"],
        message: json["message"],
        data: List<SericeCategories>.from(
            json["data"].map((x) => SericeCategories.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SericeCategories {
  SericeCategories({
    this.categoryId,
    this.categoryName,
    this.description,
    this.categoryImage,
    this.addDate,
  });

  String? categoryId;
  String? categoryName;
  dynamic description;
  String? categoryImage;
  DateTime? addDate;

  factory SericeCategories.fromJson(Map<String, dynamic> json) =>
      SericeCategories(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        description: json["description"],
        categoryImage: json["categoryImage"],
        addDate: DateTime.parse(json["addDate"]),
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "description": description,
        "categoryImage": categoryImage,
        "addDate": addDate!.toIso8601String(),
      };
}
