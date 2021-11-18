import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/constants.dart';
import 'package:urban/customerApp/components/acc_setings_fields.dart';
import 'package:urban/customerApp/services/profile_services.dart';
import 'package:urban/customerApp/views/login_signup.dart';
import 'package:urban/services/sign_in_sign_up.dart';

class AccountSettings extends StatefulWidget {
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {


  bool isDiscount = false;
  @override
  void initState() {
    super.initState();
    final pro = Provider.of<CustomerProfileServices>(context,listen: false);
    final pros = Provider.of<SignInSignUpProvider>(context,listen: false);
    pro.firstNameCont = TextEditingController(text: pros.sHuserFirst);
    pro.lastNameCont = TextEditingController(text: pros.sHuserLast);
    pro.emailCont = TextEditingController(text: pros.sHuserEmail);
    pro.phoneCont = TextEditingController(text: pros.sHPhone != null ? pros.sHPhone : "");
  }

  @override
  Widget build(BuildContext context) {
    final pros = Provider.of<SignInSignUpProvider>(context);
    final pro = Provider.of<CustomerProfileServices>(context);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text("Account settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AccSettingsField("First name", pro.firstNameCont),
                    AccSettingsField("Last Name", pro.lastNameCont),
                    AccSettingsField("Nickname", pro.nickName),
                    AccSettingsField("Email address", pro.emailCont),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text("Phone"),
                            CountryCodePicker(
                              onChanged: (val) {
                                // countryCode = val;
                                pro.countryCode = val.dialCode;
                              },
                              initialSelection: pros.sHCountryCode != null ? '${pros.sHCountryCode.toString()}' : '+44',
                              showDropDownButton: true,
                            ),
                            Expanded(
                              child: TextField(
                                controller: pro.phoneCont,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                Row(
                  children: [
                    Text("Country"),
                    Expanded(
                      child: CountryCodePicker(
                        enabled: true,
                        showFlagMain: true,
                        showCountryOnly: true,
                        onChanged: (val) {
                          // countryCode = val;
                          pro.country = val.name;
                          print(val.name);
                        },
                        initialSelection: pros.sHCountryCode != null ? '${pros.sHCountryCode.toString()}' : '+44',
                        showDropDownButton: true,
                        showOnlyCountryWhenClosed: true,
                      ),
                    )
                  ],
                ),
                    Divider(thickness: 2,),
                    // DropdownButton(
                    //   hint: Text("Select your city"),
                    //   itemHeight: 80.0,
                    //   isExpanded: true,
                    //   icon: Icon(Icons.arrow_drop_down),
                    //   value: pro.selectedLocation,
                    //   onChanged: (newValue) {
                    //     pro.changeLocation(newValue.toString());
                    //   },
                    //   items: pro.locations.map((location) {
                    //     return DropdownMenuItem(
                    //       child: new Text(location),
                    //       value: location,
                    //     );
                    //   }).toList(),
                    // ),
                    SizedBox(
                      height: 30,
                    ),
                    Text("OTHER SETTINGS"),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text("I confirm I am over the age of 18 or have a parent or guardian’s consent to use Metis"),),
                          Platform.isIOS
                            ? CupertinoSwitch(
                                value: isDiscount,
                                onChanged: (val) {
                                  setState(() {
                                    isDiscount = val;
                                  });
                                },
                              )
                            : Switch(
                                activeTrackColor: Colors.green,
                                activeColor: Colors.white,
                                value: isDiscount,
                                onChanged: (va) {
                                  setState(() {
                                    isDiscount = va;
                                  });
                                },
                             ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text("Turn on Notifications"),),
                          Platform.isIOS
                              ? CupertinoSwitch(
                            value: isDiscount,
                            onChanged: (val) {
                              setState(() {
                                isDiscount = val;
                              });
                            },
                          )
                              : Switch(
                            activeTrackColor: Colors.green,
                            activeColor: Colors.white,
                            value: isDiscount,
                            onChanged: (va) {
                              setState(() {
                                isDiscount = va;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text("Turn on passcode"),),
                          Platform.isIOS
                              ? CupertinoSwitch(
                            value: isDiscount,
                            onChanged: (val) {
                              setState(() {
                                isDiscount = val;
                              });
                            },
                          )
                              : Switch(
                            activeTrackColor: Colors.green,
                            activeColor: Colors.white,
                            value: isDiscount,
                            onChanged: (va) {
                              setState(() {
                                isDiscount = va;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: (){
                            // Navigator.push(context, MaterialPageRoute(builder:))
                          },
                          child: Text("CHANGE PASSWORD",style: TextStyle(color: page1Color),),
                          ),
                          TextButton(
                          onPressed: (){
                            showDialog(
                              context: context,
                              builder: (ctx){
                                return AlertDialog(
                                  title: Text("Are you sure you want to logout?"),
                                  clipBehavior: Clip.antiAlias,
                                  // content: Text("if you logout your account you need to sign in again"),
                                  actions: [
                                    TextButton(
                                      onPressed:(){
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed:()async{
                                        await pros.logOutFromShared();
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginSignUp()), (route) => false);
                                      },
                                      child: Text("Logout"),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: Text("LOG OUT",style: TextStyle(color: page1Color),),
                          ),
                      ],
                    ),
                    Divider()
                  ],
                ),
              ),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                height: 50,
                minWidth: MediaQuery.of(context).size.width,
                color: kButtonColor,
                shape: StadiumBorder(),
                onPressed: (){
                  pro.updateUserProfile(context);
                },
                child: Text("Save changes"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
