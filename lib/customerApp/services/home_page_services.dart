import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:urban/api_urls.dart';
import 'package:urban/customerApp/models/categories.dart';
import 'package:http/http.dart' as http;
import 'package:urban/customerApp/models/fav_services.dart';
import 'package:urban/customerApp/models/nearby_providers.dart';
import 'package:urban/customerApp/models/provider_service_detail.dart';
import 'package:urban/customerApp/models/sub_categories.dart';
import 'package:urban/services/sign_in_sign_up.dart';

// this class is for all home pages API servies use
class HomePageServices extends ChangeNotifier {
  DateTime dateTime = DateTime.now();
  bool isTimeSelected = false;
  static DateTime sdateTime = DateTime.now();
  bool haveProviderAccount = false;

  double? latitude;
  double? longitude;
  String? selectedDate = '${sdateTime.year}/${sdateTime.month}/${sdateTime.day}';
  String? selectedTime;
  bool isSearching = false;
  String preiod = '30';
  String? endTime;

  void printt(){
    print(endTime);
  }

  void calculateEndTime(){
    print(preiod);
    if(preiod == '30'){
      switch(selectedTime){
        case '6:00AM':
          endTime = '6:30AM';
          break;
        case '7:00AM':
          endTime = '7:30AM';
          break;
        case '8:00AM':
          endTime = '8:30AM';
          break;
        case '9:00AM':
          endTime = '9:30AM';
          break;
        case '10:00AM':
          endTime = '10:30AM';
          break;
        case '11:00AM':
          endTime = '11:30AM';
          break;
        case '12:00PM':
          endTime = '12:30PM';
          break;
        case '1:00AM':
          endTime = '1:30PM';
          break;
        case '2:00PM':
          endTime = '2:30PM';
          break;
        case '3:00AM':
          endTime = '3:30PM';
          break;
        case '4:00PM':
          endTime = '4:30PM';
          break;
        case '5:00AM':
          endTime = '5:30PM';
          break;
        case '6:00PM':
          endTime = '6:30PM';
          break;
        case '7:00AM':
          endTime = '7:30PM';
          break;
        case '8:00AM':
          endTime = '8:30PM';
          break;
      }
    }else if(preiod == '60'){
      switch(selectedTime){
        case '6:00AM':
          endTime = '7:00AM';
          break;
        case '7:00AM':
          endTime = '8:00AM';
          break;
        case '8:00AM':
          endTime = '9:00AM';
          break;
        case '9:00AM':
          endTime = '10:00AM';
          break;
        case '10:00AM':
          endTime = '11:00AM';
          break;
        case '11:00AM':
          endTime = '12:00PM';
          break;
        case '12:00PM':
          endTime = '1:00AM';
          break;
        case '1:00PM':
          endTime = '2:00PM';
          break;
        case '2:00PM':
          endTime = '3:00PM';
          break;
        case '3:00PM':
          endTime = '4:00PM';
          break;
        case '4:00PM':
          endTime = '5:00PM';
          break;
        case '5:00PM':
          endTime = '6:00PM';
          break;
        case '6:00PM':
          endTime = '7:00PM';
          break;
        case '7:00PM':
          endTime = '8:00PM';
          break;
        case '8:00PM':
          endTime = '9:00PM';
          break;
      }
    }else{
      switch(selectedTime){
        case '6:00AM':
          endTime = '8:00AM';
          break;
        case '7:00AM':
          endTime = '9:00AM';
          break;
        case '8:00AM':
          endTime = '10:00AM';
          break;
        case '9:00AM':
          endTime = '11:00AM';
          break;
        case '10:00AM':
          endTime = '12:00PM';
          break;
        case '11:00AM':
          endTime = '1:00PM';
          break;
        case '12:00PM':
          endTime = '2:00PM';
          break;
        case '1:00PM':
          endTime = '3:00PM';
          break;
        case '2:00PM':
          endTime = '4:00PM';
          break;
        case '3:00PM':
          endTime = '5:00PM';
          break;
        case '4:00PM':
          endTime = '6:00PM';
          break;
        case '5:00PM':
          endTime = '7:00PM';
          break;
        case '6:00PM':
          endTime = '8:00PM';
          break;
        case '7:00PM':
          endTime = '9:00PM';
          break;
        case '8:00PM':
          endTime = '10:00PM';
          break;
      }
    }
  }

  Future<void> getLocation()async{
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((location){
      latitude = location.latitude;
      longitude = location.longitude;
    });
    print(latitude);
    print(longitude);
    notifyListeners();
  }

  List<ServiceTime> serviceTime = [
    ServiceTime("6:00AM", false),
    ServiceTime("7:00AM", false),
    ServiceTime("8:00AM", false),
    ServiceTime("9:00AM", false),
    ServiceTime("10:00AM", false),
    ServiceTime("11:00AM", false),
    ServiceTime("12:00PM", false),
    ServiceTime("1:00PM", false),
    ServiceTime("2:00PM", false),
    ServiceTime("3:00PM", false),
    ServiceTime("4:00PM", false),
    ServiceTime("5:00PM", false),
    ServiceTime("6:00PM", false),
    ServiceTime("7:00PM", false),
    ServiceTime("8:00PM", false),
  ];

  void makeTimeSelec(int i){
    for(var li in serviceTime){
      li.isSelected = false;
    }
    serviceTime[i].isSelected = true;
    notifyListeners();
  }
  void clearProvidersList(){
    if(nearProviders!.length > 0){
      nearProviders!.clear();
    }
    isSearching = true;
    notifyListeners();
  }
  void timeSelected(){
    isTimeSelected = true;
    notifyListeners();
  }

  // fetching home page categories
  List<SericeCategories>? categories = [];
  Future<void> fetchCategoris() async {
    Uri url = Uri.parse(kCategoriesUrl);
    final response = await http.get(url);
    if (200 == response.statusCode) {
      final result = categoriesFromJson(response.body);
      categories = result.data;
      print(categories);
    } else {
      categories = [];
    }
    notifyListeners();
  }

  // fetching home page sub Categories
  List<SubCategoriesData>? subCategories = [];
  Future<void> fetchSubCategoris(String categoryId) async {
    print(categoryId);
    Uri url = Uri.parse(kSubCategoriesUrl);
    final response = await http.post(url,
        body: ({
          'categoryId': categoryId,
        }));
    if (200 == response.statusCode) {
      final result = subCategoriesFromJson(response.body);
      subCategories = result.data;
      print("Success");
    } else {
      subCategories = [];
    }
    notifyListeners();
  }

  // near providers fetching
  List<NearbyProvidersList>? nearProviders = [];
  Future<void> fetchNearProviders(String subCatId) async {
    Uri url = Uri.parse(kfetchNearbyProvidersUrl);
    print(latitude);
    final response = await http.post(url, body: ({
      'latitude': '25.165173',
      'longitude': '68.083799',
      'subcategoryId': subCatId,
      'date': selectedDate,
      'time': selectedTime,
    }));
    if (200 == response.statusCode) {
      final result = nearbyProvidersFromJson(response.body);
      nearProviders = result.data;
      isSearching = false;
      print(jsonDecode(response.body));
      print("Success");
      print(nearProviders!.length);
    } else {
      nearProviders = [];
    }
    notifyListeners();
  }


  // fetch provider and service detail
  ProviderServicesDetail? providerServices;
  Future<void> fetchProviderAndServiceDetails(String? serviceId) async {
    Uri url = Uri.parse(kFetchProviderAndServiceDetails);
    print(latitude);
    final response = await http.post(url, body: ({
      'serviceId' : serviceId,
    }));
    if (200 == response.statusCode) {
      final result = providerServiceDetailsFromJson(response.body);
      providerServices = result.data;
      isSearching = false;
      print(jsonDecode(response.body));
      print("Success");
      print(providerServices!.firstName);
    } else {
    }
    notifyListeners();
  }

  Future<void> addToFavorite(BuildContext context,String serviceId)async{
    Uri url = Uri.parse(kAddFavorite);
    final pro = Provider.of<SignInSignUpProvider>(context,listen: false);
    http.Response response = await http.post(url,body: ({
      'userId': pro.sHuserid,
      'serviceId': serviceId,
    }));
    var dec = json.decode(response.body);
    print(dec);
  }

  FavServces? favServices;
  Future<void> fetchFavoriteServices(BuildContext context) async {
    final pro = Provider.of<SignInSignUpProvider>(context,listen: false);
    print("er IDddddddd ${pro.sHuserid}");
    Uri url = Uri.parse(kFetchFavServices);
    final response = await http.post(url, body: ({
      'userId' : pro.sHuserid,
    }));
    print(response.body);
    if (200 == response.statusCode) {
      final result = favServcesFromJson(response.body);

      favServices = result;
      print(jsonDecode(response.body));
      print("Successsssssssssss");
    } else {
    }
    notifyListeners();
  }

  Future<void> checkProviderAccount(BuildContext context)async{

    // final pro = Provider.of<SignInSignUpProvider>(context,listen: false);
    // Uri url = Uri.parse(kCheckProvider);
    // final response = await http.post(url, body: ({
    //   'userId' : pro.sHuserid,
    // }));
    // var dec = json.decode(response.body);
    // print(dec['data']['provider']);
    // if(response.statusCode == 200){
    //   dec['data']['provider'] == '0' ? haveProviderAccount = false : haveProviderAccount = true;
    //   print(haveProviderAccount);
    // }
    notifyListeners();

  }
  List<String> questions = [
    'I have a question about the service',
    "I'm a registered client and I need support",
    "I'm a counselor interested in joining.",
    "I'm a registered counselor and I need support",
    'I have a business inquiry.',
    'I have a billing related question',
    'I have feedback, compliments or complaints',
  ];
  String selectedQuestions = "I have a question about the service";
  void changeQuestions(String val) {
    selectedQuestions = val;
    notifyListeners();
  }

}

class ServiceTime {
  String time;
  bool isSelected;
  ServiceTime(this.time,this.isSelected);
}
