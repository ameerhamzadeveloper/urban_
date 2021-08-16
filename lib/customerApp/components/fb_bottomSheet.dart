import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:urban/constants.dart';
import 'package:urban/services/sign_in_sign_up.dart';
class FbBottomSheet extends StatefulWidget {
  @override
  _FbBottomSheetState createState() => _FbBottomSheetState();
}

class _FbBottomSheetState extends State<FbBottomSheet> {
  bool isTerms = false;
  bool isDiscount = false;

  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;

  Future<void> _logOut() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
  }

  Future<void> _login(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login(
    ); // by the fault we request the email and the public profile
    final pro = Provider.of<SignInSignUpProvider>(context,listen: false);
    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      // _printCredentials();
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      final userEm = await FacebookAuth.instance.getUserData(fields: "email");
      _userData = userData;
      print(_userData.toString());
      print(_userData?['name']);
      print(_userData?['id']);
      print(userEm);
      print(_accessToken!.token);
      pro.registerWithFacebook(context, _userData?['name'], _userData?['id'], _accessToken!.token);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //             BottomNavBar()));
    } else {
      print(result.status);
      print(result.message);
    }

    setState(() {
      // _checking = false;
    });
    print("Cliceddddd");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                color: Colors.cyan,
                onPressed: () {
                  _logOut();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.clear),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                            "You must accept the terms and conditions to continue")),
                    Platform.isIOS
                        ? CupertinoSwitch(
                      value: isTerms,
                      onChanged: (val) {

                      },
                    )
                        : Switch(
                      value: isTerms,
                      onChanged: (va) {
                        setState(() {
                          isTerms = va;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                            "I don't want a 10% discount on my second appointment. or to recieve exclusive offers news and competitions")),
                    Platform.isIOS
                        ? CupertinoSwitch(
                      value: isDiscount,
                      onChanged: (val) {
                        makeFirstSwitchButton();
                      },
                    )
                        : Switch(
                      value: isDiscount,
                      onChanged: (va) {
                        makeSecondSwitchButton();
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text("Terms & conditions"),
                SizedBox(
                  height: 10,
                ),
                Text("Privacy policy"),
                SizedBox(
                  height: 40,
                ),
                MaterialButton(
                    minWidth:
                    MediaQuery.of(context).size.width,
                    height: 50,
                    shape: StadiumBorder(),
                    color: kButtonColor,
                    onPressed: () {
                      _login(context);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             BottomNavBar()));
                    },
                    child: Text("Continue"))
              ],
            ),
          )
        ],
      ),
    );
  }
  void makeFirstSwitchButton(){
    setState(() {
      isTerms = !isTerms;
    });
  }
  void makeSecondSwitchButton(){
    setState(() {
      isDiscount = !isDiscount;
    });
  }
}
