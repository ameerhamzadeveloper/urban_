import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';
import 'package:urban/common_screens/terms_conditions.dart';
import 'package:urban/components/progress_indicator.dart';
import 'package:urban/constants.dart';
import 'package:urban/customerApp/components/create_acc_fields.dart';
import 'package:urban/services/sign_in_sign_up.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<SignInSignUpProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text("Create account"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        MaterialButton(
                          height: 50,
                          shape: StadiumBorder(),
                          color: Color(0xff3b5998),
                          onPressed: () async {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.facebook,
                                color: Colors.white,
                              ),
                              Text(
                                "Continue with Facebook",
                                style: TextStyle(color: Colors.white),
                              ),
                              Container()
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          height: 50,
                          shape: StadiumBorder(),
                          color: Colors.black,
                          onPressed: () {
                            pro.saveInfoToShared();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                FontAwesome5.apple,
                                color: Colors.white,
                              ),
                              Text(
                                "Sign in with Apple",
                                style: TextStyle(color: Colors.white),
                              ),
                              Container()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Or sign up manually"),
                            SizedBox(
                              height: 10,
                            ),
                            pro.authError != ''
                                ? Container(
                                    color: Colors.yellowAccent,
                                    height: 25,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.info,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          pro.authError ?? '',
                                          style: TextStyle(color: Colors.red),
                                        )
                                      ],
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: 30,
                            ),
                            CreateAccField(
                              "First name",
                              "Enter your first name",
                              pro.fistName,
                              (val) {
                                if (val!.isEmpty) {
                                  return "Last Name is required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            CreateAccField(
                              "Last name",
                              "Enter your last name",
                              pro.lastName,
                              (val) {
                                if (val!.isEmpty) {
                                  return "First Name is required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            CreateAccField(
                              "Email",
                              "Use a valid email",
                              pro.emailCont,
                              (val) {
                                if (val!.isEmpty) {
                                  return "Email is required";
                                } else if (!RegExp(
                                        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                    .hasMatch(val)) {
                                  return 'Please enter a valid email Address';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Password"),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        obscureText: pro.isPasswordObs,
                                        onChanged: (val) {
                                          setState(() {
                                            pro.password = val;
                                          });
                                        },
                                        validator: (val) {
                                          if (val != null) {
                                            if (val == "") {
                                              return "Please Enter Password";
                                            } else if (val.length < 6) {
                                              return "Password must at least 6 characters";
                                            }
                                          }
                                        },
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                "Use at least 6 characters",
                                            suffix: IconButton(
                                              onPressed: () {
                                                pro.setObsPassword();
                                              },
                                              icon: Icon(pro.isPasswordObs
                                                  ? Elusive.eye_off
                                                  : Elusive.eye),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 2,
                                ),
                              ],
                            ),
                            // SizedBox(height: 15,),
                            // DropdownButton(
                            //   itemHeight: 80.0,
                            //   isExpanded: true,
                            //   icon: Icon(Icons.arrow_drop_down),
                            //   // hint: Text('Select'),
                            //   // Not necessary for Option 1
                            //   value: pro.selectedLocation,
                            //   onChanged: (newValue) {
                            //    pro.changeCity(newValue.toString());
                            //   },
                            //   items: pro.locations.map((location) {
                            //     return DropdownMenuItem(
                            //       child: new Text(location),
                            //       value: location,
                            //     );
                            //   }).toList(),
                            // ),
                            Row(
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                    shape: StadiumBorder(
                                        side: BorderSide(color: Colors.grey)),
                                    color: pro.isBuyerSelect
                                        ? Colors.yellowAccent
                                        : Colors.white,
                                    onPressed: () {
                                      pro.setBuyerTrue();
                                    },
                                    child: Text("I am a patient"),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: MaterialButton(
                                    shape: StadiumBorder(
                                        side: BorderSide(color: Colors.grey)),
                                    color: pro.isProviderSelect
                                        ? Colors.yellowAccent
                                        : Colors.white,
                                    onPressed: () {
                                      pro.setProviderTrue();
                                    },
                                    child: Text("I am a practitioner"),
                                  ),
                                )
                              ],
                            ),
                            pro.isRoleEmpty
                                ? Text(pro.roleError,
                                    style: TextStyle(color: Colors.red))
                                : Container(),
                            SizedBox(
                              height: 20,
                            ),
                            MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              height: 50,
                              shape: StadiumBorder(),
                              color: kButtonColor,
                              onPressed: () {
                                //  print(firstName.text);
                                //  print(password);
                                if (_formKey.currentState!.validate()) {
                                  if (pro.isProviderSelect == true ||
                                      pro.isBuyerSelect == true) {
                                    print("Everything Okay");
                                    pro.registerUser(context);
                                    pro.makeSignUp();
                                  } else {
                                    pro.setRoleEmptyTrue();
                                  }
                                }
                              },
                              child: Text("Sign Up"),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "SUPPORT",
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => TermsConditions()
                                    ));
                                  },
                                  child: Text(
                                    "TERMS & CONDITIONS",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "PRIVACY POLICY",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          pro.isSignUpPressed
              ? Align(
                  alignment: Alignment.center,
                  child: AppProgressIndicator(),
                )
              : Container()
        ],
      ),
    );
  }
}
