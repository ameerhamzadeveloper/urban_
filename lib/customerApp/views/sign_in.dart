import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/progress_indicator.dart';
import 'package:urban/constants.dart';
import 'package:urban/customerApp/views/forgot_password.dart';
import 'package:urban/services/sign_in_sign_up.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> fomrKey = GlobalKey<FormState>();
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
        title: Text("Sign in"),
      ),
      body: Container(
        color: pro.isSignInPressed ? Colors.grey[100] : Colors.white,
        child: Stack(
          children: [
            Form(
              key: fomrKey,
              child: SingleChildScrollView(
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
                            onPressed: () {},
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
                            onPressed: () {},
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
                        elevation: 3.0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Or sign in manually"),
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
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) {
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
                                onChanged: (val) {
                                  pro.email = val;
                                },
                                decoration: InputDecoration(hintText: "Email"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                obscureText: pro.isSignInPassObs,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Please Enter Password";
                                  }
                                },
                                onChanged: (val) {
                                  pro.password = val;
                                },
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    suffix: IconButton(
                                      onPressed: () {
                                        pro.makeSigninObs();
                                      },
                                      icon: Icon(pro.isSignInPassObs
                                          ? Elusive.eye_off
                                          : Elusive.eye),
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                                    },
                                    child: Text("Forgot Password?"),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                height: 50,
                                shape: StadiumBorder(),
                                color: kButtonColor,
                                onPressed: () {
                                  if (fomrKey.currentState!.validate()) {
                                    print("Caleed.");
                                    pro.makeSignin();
                                    pro.makeErrorNull();
                                    pro.signInUser(context);
                                    print("Valid");
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                                  }
                                },
                                child: Text("Sign in"),
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
                                  Text(
                                    "TERMS & CONDITIONS",
                                    style: TextStyle(fontSize: 12),
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
            pro.isSignInPressed
                ? Align(
                    alignment: Alignment(0.0, 0.0),
                    child: AppProgressIndicator())
                : Container()
          ],
        ),
      ),
    );
  }
}
