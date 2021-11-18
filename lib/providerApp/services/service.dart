import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban/api_urls.dart';
import 'package:urban/customerApp/models/current_booking_model.dart';
import 'package:urban/customerApp/models/fetch_previous_booking.dart';
import 'package:urban/navigation_transactions/bounce_transactions.dart';
import 'package:urban/providerApp/model/services_model.dart';
import 'package:urban/providerApp/views/services/success_message.dart';
import 'package:urban/services/sign_in_sign_up.dart';

class Services extends ChangeNotifier {
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  bool saturday = false;
  bool sunday = false;
  bool monday = true;
  bool tuesday = false;
  bool wednesday = false;
  bool thursday = false;
  bool friday = false;
  bool isPicSelected = false;
  bool isPublish = false;
  bool isServiceAdd = false;
  String? userId;

  bool isStartTimeSelected = false;
  bool isEndTimeSelected = false;

  String? serviceName;
  String? servicePrice;
  String? description;
  PickedFile? image;

  Future<void> getUserId() async {
    SharedPreferences pr = await SharedPreferences.getInstance();
    userId = pr.getString('userId');
    notifyListeners();
  }

  void slectDay(String value) {
    switch (value) {
      case "saturday":
        saturday = !saturday;
        break;
      case "sunday":
        sunday = !sunday;
        break;
      case "monday":
        monday = !monday;
        break;
      case "teusday":
        tuesday = !tuesday;
        break;
      case "wednesday":
        wednesday = !wednesday;
        break;
      case "thursday":
        thursday = !thursday;
        break;
      case "friday":
        friday = !friday;
        break;
    }
    notifyListeners();
  }

  void submitServiceCalled() {
    isServiceAdd = !isServiceAdd;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final PickedFile? pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    image = pickedImage;
    notifyListeners();
  }

  Future<void> selectStartTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != selectedStartTime) {
      selectedStartTime = newTime;
    }
    print(selectedStartTime.format(context));
    isStartTimeSelected = true;
    notifyListeners();
  }

  Future<void> selectEndTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != selectedEndTime) {
      selectedEndTime = newTime;
    }
    isEndTimeSelected = true;
    print(selectedEndTime);
    notifyListeners();
  }

  List<String> servicesList = [
    'Select Category',
    'massage',
    'online tuiter',
    'water splay',
    'handyman',
    'in person',
  ];

  String selectedService = "Select Category";
  List<String> subServicesList = [
    'Select sub-treatment',
    'massage',
    'online tuiter',
    'water splay',
    'handyman',
    'in person',
  ];
  String selectedSubServices = "Select sub-treatment";

  void changeSubService(String val) {
    selectedSubServices = val;
    notifyListeners();
  }

  void isPublishService() {
    isPublish = !isPublish;
    notifyListeners();
  }

  void changeService(String val) {
    selectedService = val;
    notifyListeners();
  }

  Widget showSelfieImage() {
    if (image != null) {
      return Image.file(
        File(image!.path),
        fit: BoxFit.fill,
        height: 120,
        // width: 120,
      );
    } else {
      return Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Upload a photo of yourself so your patients can put a face to a name"),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 200,
              decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 3),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    pickImage();
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    size: 50,
                  ),
                ),
              )),
        ],
      ));
    }
  }

  Future<void> publishService(BuildContext context) async {
    try {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              "https://urbanexample.000webhostapp.com/index.php/v1/provider/AddService"));

      var servicePhoto =
          await http.MultipartFile.fromPath('serviceImage', image!.path);

      request.fields['userId'] = userId.toString();
      request.fields['serviceName'] = serviceName!;
      request.fields['categoryId'] = '1';
      request.fields['subCategoryId'] = '1';
      request.fields['servicePrice'] = servicePrice!;
      request.fields['serviceStartTime'] =
          selectedStartTime.format(context).toString();
      request.fields['serviceEndTime'] =
          selectedEndTime.format(context).toString();
      request.fields['serviceDescription'] = description!;

      request.fields['monday'] = '1';
      request.fields['tuesday'] = tuesday ? '1' : '0';
      request.fields['wednesday'] = wednesday ? '1' : '0';
      request.fields['thursday'] = thursday ? '1' : '0';
      request.fields['friday'] = friday ? '1' : '0';
      request.fields['saturday'] = saturday ? '1' : '0';
      request.fields['sunday'] = sunday ? '1' : '0';

      request.fields['latitude'] = '25.165173';
      request.fields['longitude'] = '68.083799';
      request.fields['serviceStatus'] = isPublish ? '1' : '0';

      request.files.add(servicePhoto);

      http.StreamedResponse response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        // if(value == "You must chose image")
        // Navigator.pushNamed(context, resturantHome);
        final de = json.decode(value);
        print(de);
        print(" this is status code ${response.statusCode}");
        // print(response.statusCode);
        if (200 == response.statusCode) {
          print(response.statusCode);
          Navigator.pushReplacement(
              context, ScaleRoute(page: SuccessMessage()));
          submitServiceCalled();
        }
        //   print("Something went wrong");
        // }
        // Navigator.pushNamedAndRemoveUntil(context, resturantHome, (route) => false);
      });
    } catch (e) {
      print(e);
      print(e);
    }
  }

  Future<void> fetchServices(BuildContext context) async {
    final pro = Provider.of<SignInSignUpProvider>(context, listen: false);
    print(pro.sHuserid);
    http.Response response = await http.post(Uri.parse("$kFetchServiceUrl"),
        body: ({
          'userId': userId,
        }));
    var de = json.decode(response.body);
    print(de);
    for (var d in de['data']) {
      services.add(ServiceModel(
        d['serviceId'],
        d['serviceName'],
        d['categoryId'],
        d['subCategoryId'],
        d['servicePrice'],
        d['serviceStartTime'],
        d['serviceEndTime'],
        d['serviceDescription'],
        d['serviceImage'],
        d['monday'],
        d['tuesday'],
        d['wednesday'],
        d['thursday'],
        d['friday'],
        d['saturday'],
        d['sunday'],
        d['latitude'],
        d['longitude'],
        d['userId'],
        d['serviceStatus'],
        d['addDate'],
      ));
    }
    notifyListeners();
  }

  List<ServiceModel> services = [];

  Future<void> pauseOrActiveService(String serviceId, String serviceStatus)async{
    Uri url = Uri.parse(kActivePauseService);
    http.Response response = await http.post(url,body: ({
      'serviceId': serviceId,
      'serviceStatus': serviceStatus,
    }));
    if(200 == response.statusCode){
      print(json.decode(response.body));
    }
    notifyListeners();
  }

  Future<void> deleteService(String serviceId)async{
    Uri url = Uri.parse(kDeleteService);
    http.Response response = await http.post(url,body: ({
      'serviceId': serviceId,
    }));
    if(200 == response.statusCode){
      print(json.decode(response.body));
    }
    notifyListeners();
  }

  List<CurrentBooking>? currentBook;
  Future<void> fetchCurrentBooked(BuildContext context)async{
    final idPro = Provider.of<SignInSignUpProvider>(context,listen: false);
    Uri url = Uri.parse(kFetchProviderCurrentBook);
    http.Response response = await http.post(url,body: ({
      'userId': idPro.sHuserid,
    }));
    if(response.statusCode == 200){
      var data = currentOrderModelFromJson(response.body);
      currentBook = data.data;
      print(currentBook.toString());
    }else{
      currentBook  = [];
    }
    notifyListeners();
  }


  List<PreviousBooking>? pastBooking;

  Future<void> fetchPastBooking(BuildContext context)async{
    final idPro = Provider.of<SignInSignUpProvider>(context,listen: false);
    Uri url = Uri.parse(kFetchProviderPastBooking);
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
