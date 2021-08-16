import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:urban/constants.dart';
import 'package:urban/providerApp/services/dashboard.dart';
import 'package:urban/services/sign_in_sign_up.dart';

class ProviderProfile extends StatefulWidget {
  @override
  _ProviderProfileState createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
  late TextEditingController fnameController;
  late TextEditingController lnameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  Completer<GoogleMapController> completer = Completer();
  static LatLng latLng = LatLng(24.832234, 67.062513);

  LatLng initPostition = latLng;

  onCameraMove(CameraPosition position) {
    initPostition = position.target;
  }

  onMapCreated(GoogleMapController controller) {}

  @override
  void initState() {
    super.initState();
    final pro = Provider.of<SignInSignUpProvider>(context, listen: false);
    fnameController =
        TextEditingController(text: pro.sHuserFirst);
    lnameController = TextEditingController(text: pro.sHuserLast);
    phoneController = TextEditingController(text: "");
    addressController = TextEditingController(text: pro.sHuserEmail);
  }

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<SignInSignUpProvider>(context);
    final prod = Provider.of<DashBoard>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("My Profile"),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 6, color: kProfileCircleBorderColor)),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: page2Color,
                        child: Text(
                          "${pro.sHuserFirst!.substring(0, 1).toUpperCase()}${pro.sHuserLast!.substring(0, 1).toUpperCase()}",
                          style:
                              TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(height: 10,),
                Text("First Name"),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: fnameController,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ),
                Text("Last Name"),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: lnameController,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text("Phone Number"),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text("Email Address"),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      child: TextField(
                        readOnly: true,
                        controller: addressController,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text("Your qualifications"),
                prod.showQualificationImage(context),
                SizedBox(height: 10,),
                Text("Verify Provider ID"),
                prod.showProviderIDImage(context),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  height: 40,
                  minWidth: MediaQuery.of(context).size.width,
                  color: kButtonColor,
                  shape: StadiumBorder(),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Save"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
