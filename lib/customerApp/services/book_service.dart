import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:urban/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:urban/customerApp/models/current_booking_model.dart';
import 'package:urban/customerApp/models/fetch_previous_booking.dart';
import 'package:urban/customerApp/services/home_page_services.dart';
import 'package:urban/customerApp/views/bottom_nav_bar.dart';
import 'package:urban/services/sign_in_sign_up.dart';
enum DurationVal { first, second, third }
class BookService extends ChangeNotifier{
  bool isCurrentFetching = false;

  void currentFetch(){
    isCurrentFetching = !isCurrentFetching;
    notifyListeners();
  }

  Future<void> bookService(BuildContext context) async {
    final homePro = Provider.of<HomePageServices>(context,listen: false);
    final idPro = Provider.of<SignInSignUpProvider>(context,listen: false);
    Uri url = Uri.parse(kBookService);
    final response = await http.post(url, body: ({
      'serviceId' : homePro.providerServices!.serviceId,
      'buyerId': idPro.sHuserid.toString(),
      'bookingStartTime': homePro.selectedTime,
      'bookingEndTime': homePro.endTime,
      'bookingDate': homePro.selectedDate,
      'bookedPeriod': homePro.preiod,
      'payment_mode': 'Apple',
      'paymentstatus': '1',
      'bookingStatus': 'Active',
      'serviceAmount': homePro.providerServices!.servicePrice,
      'serviceProviderId': homePro.providerServices!.userId,
    }));
    print("called");
    print(jsonDecode(response.body));
    if (200 == response.statusCode) {
      var de =jsonDecode(response.body);
      if(de['status'] == 1){
        idPro.callNotification("erASg-9dQFqI2lntLhRlSA:APA91bHfffSCboWuYwf-1hTbwObfv1NpY-ZMjbDcJFJymY5jqapVoObZ3yGjrVyxij77kAWOQWC99xx6haUPEdXMtQRXlQcUySPj5WAa55kjoGNjU7gzubtZFXmOMvRKituWU8UEGsaL", "roomId", "audio");
        fetchCurrentBooked(context);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavBar()), (route) => false);
        Fluttertoast.showToast(
            msg: "Service booked Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.grey,
        );
      }
      print("Success");
    } else {
    }
    notifyListeners();
  }

  List<CurrentBooking>? currentBook = [];

  Future<void> fetchCurrentBooked(BuildContext context)async{
    currentFetch();
    final idPro = Provider.of<SignInSignUpProvider>(context,listen: false);
    Uri url = Uri.parse(kFetchCurrentBook);
    http.Response response = await http.post(url,body: ({
      'userId': idPro.sHuserid,
    }));
    if(response.statusCode == 200){
      var data = currentOrderModelFromJson(response.body);
      currentBook = data.data;
      currentFetch();
      print(currentBook.toString());
    }else{
      currentFetch();
      currentBook  = [];
    }
    notifyListeners();
  }


  List<PreviousBooking>? pastBooking;

  Future<void> fetchPastBooking(BuildContext context)async{
    final idPro = Provider.of<SignInSignUpProvider>(context,listen: false);
    Uri url = Uri.parse(kFetchPastBooking);
    http.Response response = await http.post(url,body: ({
      'userId': idPro.sHuserid,
    }));
    if(response.statusCode == 200){
      var data = fetchPreviousBookingFromJson(response.body);
      pastBooking = data.data;
      print(pastBooking.toString());
    }else{
      pastBooking  = [];
    }
    notifyListeners();
  }
}