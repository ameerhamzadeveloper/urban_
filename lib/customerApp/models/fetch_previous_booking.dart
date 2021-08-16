// To parse this JSON data, do
//
//     final fetchPreviousBooking = fetchPreviousBookingFromJson(jsonString);

import 'dart:convert';

FetchPreviousBooking fetchPreviousBookingFromJson(String str) => FetchPreviousBooking.fromJson(json.decode(str));

String fetchPreviousBookingToJson(FetchPreviousBooking data) => json.encode(data.toJson());

class FetchPreviousBooking {
  FetchPreviousBooking({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<PreviousBooking>? data;

  factory FetchPreviousBooking.fromJson(Map<String, dynamic> json) => FetchPreviousBooking(
    status: json["status"],
    message: json["message"],
    data: List<PreviousBooking>.from(json["data"].map((x) => PreviousBooking.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PreviousBooking {
  PreviousBooking({
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

  factory PreviousBooking.fromJson(Map<String, dynamic> json) => PreviousBooking(
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
