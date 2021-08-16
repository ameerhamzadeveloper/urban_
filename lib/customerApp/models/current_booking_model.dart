import 'dart:convert';

CurrentOrderModel currentOrderModelFromJson(String str) => CurrentOrderModel.fromJson(json.decode(str));

String currentOrderModelToJson(CurrentOrderModel data) => json.encode(data.toJson());

class CurrentOrderModel {
  CurrentOrderModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<CurrentBooking>? data;

  factory CurrentOrderModel.fromJson(Map<String, dynamic> json) => CurrentOrderModel(
    status: json["status"],
    message: json["message"],
    data: List<CurrentBooking>.from(json["data"].map((x) => CurrentBooking.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CurrentBooking {
  CurrentBooking({
    this.bookingId,
    this.serviceId,
    this.buyerId,
    this.bookingStartTime,
    this.bookingEndTime,
    this.bookingDate,
    this.bookedPeriod,
    this.bookingStatus,
    this.paymentMode,
    this.paymentstatus,
    this.addDate,
    this.serviceName,
    this.serviceDescription,
    this.servicePrice,
    this.serviceImage,
  });

  String? bookingId;
  String? serviceId;
  String? buyerId;
  String? bookingStartTime;
  String? bookingEndTime;
  String? bookingDate;
  String? bookedPeriod;
  String? bookingStatus;
  String? paymentMode;
  String? paymentstatus;
  DateTime? addDate;
  String? serviceName;
  String? serviceDescription;
  String? servicePrice;
  String? serviceImage;

  factory CurrentBooking.fromJson(Map<String, dynamic> json) => CurrentBooking(
    bookingId: json["bookingId"],
    serviceId: json["serviceId"],
    buyerId: json["buyerId"],
    bookingStartTime: json["bookingStartTime"],
    bookingEndTime: json["bookingEndTime"],
    bookingDate: json["bookingDate"],
    bookedPeriod: json["bookedPeriod"],
    bookingStatus: json["bookingStatus"],
    paymentMode: json["payment_mode"],
    paymentstatus: json["paymentstatus"],
    addDate: DateTime.parse(json["addDate"]),
    serviceName: json["serviceName"],
    serviceDescription: json["serviceDescription"],
    servicePrice: json["servicePrice"],
    serviceImage: json["serviceImage"],
  );

  Map<String, dynamic> toJson() => {
    "bookingId": bookingId,
    "serviceId": serviceId,
    "buyerId": buyerId,
    "bookingStartTime": bookingStartTime,
    "bookingEndTime": bookingEndTime,
    "bookingDate": bookingDate,
    "bookedPeriod": bookedPeriod,
    "bookingStatus": bookingStatus,
    "payment_mode": paymentMode,
    "paymentstatus": paymentstatus,
    "addDate": addDate!.toIso8601String(),
    "serviceName": serviceName,
    "serviceDescription": serviceDescription,
    "servicePrice": servicePrice,
    "serviceImage": serviceImage,
  };
}
