// To parse this JSON data, do
//
//     final providerServiceDetails = providerServiceDetailsFromJson(jsonString);

import 'dart:convert';

ProviderServiceDetails providerServiceDetailsFromJson(String str) => ProviderServiceDetails.fromJson(json.decode(str));

String providerServiceDetailsToJson(ProviderServiceDetails data) => json.encode(data.toJson());

class ProviderServiceDetails {
  ProviderServiceDetails({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  ProviderServicesDetail? data;

  factory ProviderServiceDetails.fromJson(Map<String, dynamic> json) => ProviderServiceDetails(
    status: json["status"],
    message: json["message"],
    data: ProviderServicesDetail.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class ProviderServicesDetail {
  ProviderServicesDetail({
    this.serviceId,
    this.serviceName,
    this.categoryId,
    this.subCategoryId,
    this.servicePrice,
    this.serviceStartTime,
    this.serviceEndTime,
    this.serviceDescription,
    this.serviceImage,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
    this.latitude,
    this.longitude,
    this.userId,
    this.serviceStatus,
    this.addDate,
    this.firstName,
    this.profileImage,
  });

  String? serviceId;
  String? serviceName;
  String? categoryId;
  String? subCategoryId;
  String? servicePrice;
  String? serviceStartTime;
  String? serviceEndTime;
  String? serviceDescription;
  String? serviceImage;
  String? monday;
  String? tuesday;
  String? wednesday;
  String? thursday;
  String? friday;
  String? saturday;
  String? sunday;
  String? latitude;
  String? longitude;
  String? userId;
  String? serviceStatus;
  DateTime? addDate;
  String? firstName;
  dynamic profileImage;

  factory ProviderServicesDetail.fromJson(Map<String, dynamic> json) => ProviderServicesDetail(
    serviceId: json["serviceId"],
    serviceName: json["serviceName"],
    categoryId: json["categoryId"],
    subCategoryId: json["subCategoryId"],
    servicePrice: json["servicePrice"],
    serviceStartTime: json["serviceStartTime"],
    serviceEndTime: json["serviceEndTime"],
    serviceDescription: json["serviceDescription"],
    serviceImage: json["serviceImage"],
    monday: json["monday"],
    tuesday: json["tuesday"],
    wednesday: json["wednesday"],
    thursday: json["thursday"],
    friday: json["friday"],
    saturday: json["saturday"],
    sunday: json["sunday"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    userId: json["userId"],
    serviceStatus: json["serviceStatus"],
    addDate: DateTime.parse(json["addDate"]),
    firstName: json["firstName"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "serviceId": serviceId,
    "serviceName": serviceName,
    "categoryId": categoryId,
    "subCategoryId": subCategoryId,
    "servicePrice": servicePrice,
    "serviceStartTime": serviceStartTime,
    "serviceEndTime": serviceEndTime,
    "serviceDescription": serviceDescription,
    "serviceImage": serviceImage,
    "monday": monday,
    "tuesday": tuesday,
    "wednesday": wednesday,
    "thursday": thursday,
    "friday": friday,
    "saturday": saturday,
    "sunday": sunday,
    "latitude": latitude,
    "longitude": longitude,
    "userId": userId,
    "serviceStatus": serviceStatus,
    "addDate": addDate!.toIso8601String(),
    "firstName": firstName,
    "profileImage": profileImage,
  };
}
