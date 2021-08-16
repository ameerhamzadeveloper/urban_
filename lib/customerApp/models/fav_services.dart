// To parse this JSON data, do
//
//     final favServces = favServcesFromJson(jsonString);

import 'dart:convert';

FavServces favServcesFromJson(String str) => FavServces.fromJson(json.decode(str));

String favServcesToJson(FavServces data) => json.encode(data.toJson());

class FavServces {
  FavServces({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<FavSer>? data;

  factory FavServces.fromJson(Map<String, dynamic> json) => FavServces(
    status: json["status"],
    message: json["message"],
    data: List<FavSer>.from(json["data"].map((x) => FavSer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FavSer {
  FavSer({
    this.favrioutId,
    this.userId,
    this.serviceId,
    this.isFavriout,
    this.addDate,
    this.serviceName,
    this.categoryId,
    this.subCategoryId,
    this.servicePrice,
    this.serviceDescription,
    this.serviceImage,
    this.serviceProviderId,
  });

  String? favrioutId;
  String? userId;
  String? serviceId;
  String? isFavriout;
  DateTime? addDate;
  String? serviceName;
  String? categoryId;
  String? subCategoryId;
  String? servicePrice;
  String? serviceDescription;
  String? serviceImage;
  String? serviceProviderId;

  factory FavSer.fromJson(Map<String, dynamic> json) => FavSer(
    favrioutId: json["favrioutId"],
    userId: json["userId"],
    serviceId: json["serviceId"],
    isFavriout: json["isFavriout"],
    addDate: DateTime.parse(json["addDate"]),
    serviceName: json["serviceName"],
    categoryId: json["categoryId"],
    subCategoryId: json["subCategoryId"],
    servicePrice: json["servicePrice"],
    serviceDescription: json["serviceDescription"],
    serviceImage: json["serviceImage"],
    serviceProviderId: json["serviceProviderId"],
  );

  Map<String, dynamic> toJson() => {
    "favrioutId": favrioutId,
    "userId": userId,
    "serviceId": serviceId,
    "isFavriout": isFavriout,
    "addDate": addDate!.toIso8601String(),
    "serviceName": serviceName,
    "categoryId": categoryId,
    "subCategoryId": subCategoryId,
    "servicePrice": servicePrice,
    "serviceDescription": serviceDescription,
    "serviceImage": serviceImage,
    "serviceProviderId": serviceProviderId,
  };
}
