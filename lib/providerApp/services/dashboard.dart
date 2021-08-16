import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:urban/api_urls.dart';
import 'package:urban/services/sign_in_sign_up.dart';

class DashBoard extends ChangeNotifier{
  String earnings = "0";
  String completed = "0";
  String rating = "0.0";
  String cancel = "0";
  String current = "0";

  PickedFile? qualification;
  PickedFile? providerId;


  Future<void> fetchDashboardData(BuildContext context)async{
    final idPro = Provider.of<SignInSignUpProvider>(context,listen: false);
    Uri url = Uri.parse(kFetchDashboard);
    http.Response response = await http.post(url,body: ({
      'userId': idPro.sHuserid,
    }));
    if(200 == response.statusCode){
      var de = json.decode(response.body);
      var f = de['data'];
      earnings = f["totalEarn"];
      completed = f["totalCompleted"];
      current = f["totalActive"];
      cancel = f["totalCancel"];
      rating = f["rating"];
      print(json.decode(response.body));
    }
    notifyListeners();
  }

  Future<void> pickImage() async {
    final PickedFile? pickedImage =
    await ImagePicker().getImage(source: ImageSource.gallery);
    qualification = pickedImage;
    notifyListeners();
  }

  Widget showQualificationImage(BuildContext context) {
    if (qualification != null) {
      return Card(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Image.file(
            File(qualification!.path),
            fit: BoxFit.fill,
            height: 120,
            // width: 120,
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: (){
          pickImage();
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload_outlined,size: 50,),
                    Text("Choose image"),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
  Future<void> pickProviderIDImage() async {
    final PickedFile? pickedImage =
    await ImagePicker().getImage(source: ImageSource.gallery);
    providerId = pickedImage;
    notifyListeners();
  }

  Widget showProviderIDImage(BuildContext context) {
    if (providerId != null) {
      return Card(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Image.file(
            File(providerId!.path),
            fit: BoxFit.fill,
            height: 120,
            // width: 120,
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: (){
          pickProviderIDImage();
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload_outlined,size: 50,),
                    Text("Choose image"),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
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