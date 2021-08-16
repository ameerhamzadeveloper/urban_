// To parse this JSON data, do
//
//     final subCategories = subCategoriesFromJson(jsonString);

import 'dart:convert';

SubCategories subCategoriesFromJson(String str) =>
    SubCategories.fromJson(json.decode(str));

String subCategoriesToJson(SubCategories data) => json.encode(data.toJson());

class SubCategories {
  SubCategories({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<SubCategoriesData>? data;

  factory SubCategories.fromJson(Map<String, dynamic> json) => SubCategories(
        status: json["status"],
        message: json["message"],
        data: List<SubCategoriesData>.from(
            json["data"].map((x) => SubCategoriesData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SubCategoriesData {
  SubCategoriesData({
    this.subCategoryId,
    this.categoryId,
    this.subcategoryName,
    this.subcategoryImage,
    this.addDate,
  });

  String? subCategoryId;
  String? categoryId;
  String? subcategoryName;
  String? subcategoryImage;
  DateTime? addDate;

  factory SubCategoriesData.fromJson(Map<String, dynamic> json) =>
      SubCategoriesData(
        subCategoryId: json["subCategoryId"],
        categoryId: json["categoryId"],
        subcategoryName: json["subcategoryName"],
        subcategoryImage: json["subcategoryImage"],
        addDate: DateTime.parse(json["addDate"]),
      );

  Map<String, dynamic> toJson() => {
        "subCategoryId": subCategoryId,
        "categoryId": categoryId,
        "subcategoryName": subcategoryName,
        "subcategoryImage": subcategoryImage,
        "addDate": addDate!.toIso8601String(),
      };
}
