import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban/api_urls.dart';
import 'package:urban/services/sign_in_sign_up.dart';

class CustomerProfileServices extends ChangeNotifier{

  PickedFile? image;
  String? firstName;
  String? lastName;
  String? countryCode;
  String? country;

  TextEditingController firstNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController nickName = TextEditingController();

  List<String> locations = [
    'Karachi',
    'London',
    'Peris',
    'Farwaniya',
    'Mubarak AlKabeer',
    'Jahra'
  ]; // Option 2
  String selectedLocation = "London";

  Future<void> pickImage() async {
    final PickedFile? pickedImage =
    await ImagePicker().getImage(source: ImageSource.gallery);
    image = pickedImage;
    notifyListeners();
  }

  void changeLocation(String value){
    selectedLocation = value;
    notifyListeners();
  }

  Future<void> updateUserProfileImage(BuildContext context) async {
    final pro = Provider.of<SignInSignUpProvider>(context,listen: false);
    try {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              kUpdateUserProfile),);

      var servicePhoto =
      await http.MultipartFile.fromPath('profileImage', image!.path);

      request.fields['userId'] = pro.sHuserid.toString();
      request.fields['firstName'] = firstNameCont.text;
      request.fields['lastName'] = lastNameCont.text;
      request.fields['city'] = selectedLocation;
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

        }
        //   print("Something went wrong");
        // }
        // Navigator.pushNamedAndRemoveUntil(context, resturantHome, (route) => false);
      });
    } catch (e) {
      print(e);
      print(e);
    }
    notifyListeners();
  }

  Future<void> updateUserProfile(BuildContext context) async {
    Uri url = Uri.parse(kUpdateUserProfile);
    final pro = Provider.of<SignInSignUpProvider>(context,listen: false);
    final response = await http.post(url, body: ({
      'userId': pro.sHuserid,
      'firstName': firstNameCont.text,
      'lastName': lastNameCont.text,
      'city': selectedLocation,
      'phoneNo': phoneCont.text.length < 0 ? "" : phoneCont.text,
    }));
    if (200 == response.statusCode) {
      print(json.decode(response.body));
      var de = json.decode(response.body);
      if(de['status'] == 1){
        print("yes");
        Fluttertoast.showToast(
          msg: "Profile Updated Successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.grey,
        );
        saveInfoToShared(context);
      }
    } else {
    }
    notifyListeners();
  }

  Future<void> saveInfoToShared(BuildContext context) async {
    print(countryCode.toString());
    final pro = Provider.of<SignInSignUpProvider>(context,listen: false);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('firstName', firstNameCont.text);
    preferences.setString('lastName', lastNameCont.text);
    preferences.setString('city', selectedLocation);
    preferences.setString('phone', phoneCont.text);
    preferences.setString('countryCode', countryCode.toString());
    pro.getUpdatedProfileShared();
  }

}