import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:urban/api_urls.dart';
import 'package:urban/common_screens/verify_email.dart';
import 'package:urban/customerApp/views/bottom_nav_bar.dart';
import 'package:urban/providerApp/views/home_page.dart';

class SignInSignUpProvider extends ChangeNotifier {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  String? email;
  String? password;
  String? fcmToken;
  String? error;
  bool isBuyerSelect = false;
  bool isProviderSelect = false;
  bool isRoleEmpty = false;
  String roleError = "Please enter your Role";
  String? verificationCode;
  dynamic authError = '';
  bool isSignInPressed = false;
  bool isSignInPassObs = true;
  bool isSignUpPressed = false;
  bool isVerifyPressed = false;

  // fetched values after Authentications
  dynamic userFirstName;
  dynamic userLasttName;
  dynamic userId;
  dynamic accessToken;
  dynamic userEmail;
  dynamic userType;
  dynamic userCity;
  dynamic profileImage;
  dynamic deliveredVerificationCode;

  void makeSigninObs() {
    isSignInPassObs = !isSignInPassObs;
    notifyListeners();
  }

  void setEmptyVerifyError() {
    authError = 'Please Enter Code';
    notifyListeners();
  }

  void makeVerify() {
    isVerifyPressed = !isVerifyPressed;
    notifyListeners();
  }

  void makeSignin() {
    isSignInPressed = !isSignInPressed;
    notifyListeners();
  }

  void makeSignUp() {
    isSignUpPressed = !isSignUpPressed;
    notifyListeners();
  }

  void setRoleEmptyTrue() {
    isRoleEmpty = true;
    notifyListeners();
  }

  void setRoleEmptyFalse() {
    isRoleEmpty = false;
    notifyListeners();
  }

  void setBuyerTrue() {
    isProviderSelect = false;
    isBuyerSelect = true;
    isRoleEmpty = false;
    notifyListeners();
  }

  void setProviderTrue() {
    isProviderSelect = true;
    isBuyerSelect = false;
    isRoleEmpty = false;
    notifyListeners();
  }

  void makeErrorNull() {
    authError = '';
    notifyListeners();
  }

  List<String> locations = [
    'Select your city',
    'London',
    'Paris',
    'Karachi',
    'Mubarak AlKabeer',
    'Jahra'
  ];
  String selectedLocation = "Select your city";
  TextEditingController fistName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  bool isPasswordObs = true;

  void changeCity(String val) {
    selectedLocation = val;
    notifyListeners();
  }

  void setObsPassword() {
    isPasswordObs = !isPasswordObs;
    notifyListeners();
  }

  void getFCMToken() {
    firebaseMessaging.getToken().then((token) {
      fcmToken = token;
      print(fcmToken);
    });
    notifyListeners();
  }

  Future<void> registerWithFacebook(BuildContext context, namee, id,toekn) async {
    try {
      print("nameeee ${namee.toString()}");
      print("tokeeeen ${toekn.toString()}");
      print("idddddd ${id.toString()}");
      Map<String,dynamic> body =
         ({
          'firstName': namee.toString(),
          // 'lastName': "",
          'city': '',
          'email': id.toString(),
          'password': '',
          'fcmToken': fcmToken.toString(),
          'userType': '0',
          'provider': '0',
          'signUpMode': 'facebook',
          'outhId': id.toString(),
        });
      http.Response response = await http.post(Uri.parse(kSignUpUrl),
          body: body);
      print(body.toString());
      var de = json.decode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(de);
        if (de['message'] == 'Success') {
          print(de);
          print(de['data']['userId']);
          userId = de['data']['userId'];
          userFirstName = de['data']['firstName'];
          userLasttName = de['data']['lastName'];
          userEmail = de['data']['email'];
          userCity = de['data']['city'];
          accessToken = de['data']['accessToken'];
          deliveredVerificationCode = de['data']['verificationCode'];
          profileImage = de['data']['profileImage'] == null
              ? 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1276&q=80'
              : de['data']['profileImage'];
          userType = de['data']['userType'] == '0' ? 'user' : 'provider';
          print(de['data']['userType'] == '0' ? 'user' : 'provider');
          saveInfoToShared();
          authError = '';
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBar()),
                  (route) => false);
          print("called");
        } else {
          authError = "Something Went Wrong try again later";
        }
        notifyListeners();
      }
    } catch (e) {
      error = e.toString();
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> registerUser(BuildContext context) async {
    print(fcmToken);
    try {
      print(isBuyerSelect);
      print(lastName.text);
      print(emailCont.text);
      print(password);
      http.Response response = await http.post(Uri.parse(kSignUpUrl),
          body: ({
            'firstName': fistName.text,
            'lastName': lastName.text,
            'city': 'null',
            'email': emailCont.text,
            'password': password,
            'fcmToken': fcmToken,
            'userType': isBuyerSelect ? '0' : '1',
            'provider': isProviderSelect ? '0' : '1',
            'signUpMode': 'manual',
            'outhId': '',
          }));
      var de = json.decode(response.body);
      print(de);
      if (response.statusCode == 200) {
        if (de['message'] == 'Success') {
          print(de);
          print(de['data']['userId']);
          userId = de['data']['userId'];
          userFirstName = de['data']['firstName'];
          userLasttName = de['data']['lastName'];
          userEmail = de['data']['email'];
          userCity = de['data']['city'];
          accessToken = de['data']['accessToken'];
          deliveredVerificationCode = de['data']['verificationCode'];
          profileImage = de['data']['profileImage'] == null
              ? 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1276&q=80'
              : de['data']['profileImage'];
          userType = de['data']['userType'] == '0' ? 'user' : 'provider';
          print(de['data']['userType'] == '0' ? 'user' : 'provider');
          saveInfoToShared();
          authError = '';
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => VerifyEmail()),
              (route) => false);
          print("called");
        } else {
          authError = "Something Went Wrong try again later";
        }
        notifyListeners();
      }
    } catch (e) {
      error = e.toString();
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> signInUser(BuildContext context) async {
    print(fcmToken);
    try {
      print(email);
      print(password);
      // print(fcmToken);
      http.Response response = await http.post(Uri.parse(kLoginUrl),
          body: ({
            'email': email,
            'password': password,
            'fcmToken': fcmToken,
          }));
      var de = json.decode(response.body);
      print(response.body);
      print(de['data']['userId']);
      // print()
      if (de['message'] == 'Success') {
        userId = de['data']['userId'];
        userFirstName = de['data']['firstName'];
        userLasttName = de['data']['lastName'];
        userEmail = de['data']['email'];
        userCity = de['data']['city'];
        accessToken = de['data']['accessToken'];
        profileImage = de['data']['profileImage'] == null
            ? 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1276&q=80'
            : de['data']['profileImage'];
        userType = de['data']['userType'] == '0' ? 'user' : 'provider';
        print(de['data']['userType'] == '0' ? 'user' : 'provider');
        makeSignin();
        authError = '';
        print("Got is");
        saveInfoToShared();
        if (de['data']['userType'] == '0') {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBar()),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ProviderHomePage()),
              (route) => false);
        }
      } else if (de['message'] == 'Password inccorect') {
        print("Invalid PAss");
        authError = "Invalid Password";
        makeSignin();
      } else {
        authError = "Account doesn't exists";
        print("acc does");
        makeSignin();
      }
    } catch (e) {
      error = e.toString();
    }
    notifyListeners();
  }

  void verifyEmail(BuildContext context) {
    print(verificationCode);
    print(deliveredVerificationCode);
    if (verificationCode == deliveredVerificationCode.toString()) {
      authError = '';
      makeVerify();
      getFromSharedPref();
      if (userType == 'user') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBar()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ProviderHomePage()),
            (route) => false);
      }
    } else {
      authError = "Enter Valid Code";
      makeVerify();
    }
  }

  String? sHuserid;
  String? sHuserFirst;
  String? sHuserLast;
  String? sHuserAccessToken;
  String? sHuserCity;
  String? sHuserEmail;
  String? sHPhone;
  String? sHCountryCode;

  Future<void> saveInfoToShared() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userId', userId.toString());
    preferences.setString('firstName', userFirstName ?? "");
    preferences.setString('lastName', userLasttName ?? "");
    preferences.setString('email', userEmail ?? "");
    preferences.setString('city', userCity ?? "");
    preferences.setString('userType', userType ?? "");
    preferences.setString('accessToken', accessToken ?? "");
    preferences.setString('provider', isProviderSelect ? "Yes" : "No");
    preferences.setString('user', "Yes");
  }

  Future<void> getFromSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sHuserid = preferences.getString('userId');
    sHuserFirst = preferences.getString('firstName');
    sHuserLast = preferences.getString('lastName');
    sHuserAccessToken = preferences.getString('accessToken');
    sHuserCity = preferences.getString('city');
    sHuserEmail = preferences.getString('email');
    sHPhone = preferences.getString('phone');
    sHCountryCode = preferences.getString('countryCode');
    print("user id $sHuserid");
    notifyListeners();
  }

  Future<void> getUpdatedProfileShared() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sHuserid = preferences.getString('userId');
    sHuserFirst = preferences.getString('firstName');
    sHuserLast = preferences.getString('lastName');
    sHuserAccessToken = preferences.getString('accessToken');
    sHuserCity = preferences.getString('city');
    sHuserEmail = preferences.getString('email');
    sHPhone = preferences.getString('phone');
    sHCountryCode = preferences.getString('countryCode');
    print("user id $sHuserid");
    notifyListeners();
  }

  Future<void> logOutFromShared()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    notifyListeners();
  }


  Future<void> callNotification(String fcmTo,String roomId,String callType)async{
    Uri uri = Uri.parse(kSendNotification);
    http.Response response = await http.post(uri,body: ({
      'title': '$sHuserFirst has Booked Service!',
      'fcmToken': fcmTo,
      'firstName': sHuserFirst.toString(),
      'roomId': roomId,
      'call': callType,
      'userId': sHuserid.toString(),
      'chanelId':'metis',
    }));
    var de = json.decode(response.body);
    print(de);
  }


  void joinVideoMeeting() async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.addPeopleEnabled = false;
      featureFlag.inviteEnabled = false;
      featureFlag.videoShareButtonEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution.HD_RESOLUTION; // Limit video resolution to 1280p
      var options = JitsiMeetingOptions(room : '${sHuserFirst!.substring(0, 3)}$sHuserid')
      // ..audioOnly = true
        ..subject = "Consultant"
        ..userDisplayName = sHuserFirst.toString()
        ..userEmail = sHuserEmail.toString();

      await JitsiMeet.joinMeeting(
          options,
          listener: JitsiMeetingListener(
              onConferenceTerminated: (user){
                print(user);
                print("User Ended");
              }
          )
      );
      print("Mot sendt");
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  void joinAudioMeeting() async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.addPeopleEnabled = false;
      featureFlag.inviteEnabled = false;
      featureFlag.videoShareButtonEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution.HD_RESOLUTION; // Limit video resolution to 1280p
      var options = JitsiMeetingOptions(room : '${sHuserFirst!.substring(0,3)}$sHuserid')
      ..audioOnly = true
        ..subject = "Consultant"
        ..userDisplayName = sHuserFirst.toString()
        ..userEmail = sHuserEmail.toString();

      await JitsiMeet.joinMeeting(
          options,
          listener: JitsiMeetingListener(
              onConferenceTerminated: (user){
                print(user);
                print("User Ended");
              }
          )
      );
      print("Mot sendt");
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  void acceptVideoMeeting(String roomID) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.addPeopleEnabled = false;
      featureFlag.inviteEnabled = false;
      featureFlag.videoShareButtonEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution.HD_RESOLUTION; // Limit video resolution to 1280p
      var options = JitsiMeetingOptions(room : roomID)
      // ..audioOnly = true
        ..subject = "Consultant"
        ..userDisplayName = sHuserid.toString()
        ..userEmail = sHuserEmail.toString();

      await JitsiMeet.joinMeeting(
          options,
          listener: JitsiMeetingListener(
              onConferenceTerminated: (user){
                print(user);
                print("User Ended");
              }
          )
      );
      print("Mot sendt");
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  void acceptAudioMeetings(String roomID) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.addPeopleEnabled = false;
      featureFlag.inviteEnabled = false;
      featureFlag.videoShareButtonEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution.HD_RESOLUTION; // Limit video resolution to 1280p
      var options = JitsiMeetingOptions(room : roomID)
        ..audioOnly = true
        ..subject = "Consultant"
        ..userDisplayName = sHuserid.toString()
        ..userEmail = sHuserEmail.toString();

      await JitsiMeet.joinMeeting(
          options,
          listener: JitsiMeetingListener(
              onConferenceTerminated: (user){
                print(user);
                print("User Ended");
              }
          )
      );
      print("Mot sendt");
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
