import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:urban/constants.dart';
import 'package:urban/customerApp/components/fb_bottomSheet.dart';
import 'package:urban/customerApp/views/create_acc.dart';
import 'package:urban/customerApp/views/sign_in.dart';
import 'package:http/http.dart' as http;
class LoginSignUp extends StatefulWidget {
  @override
  _LoginSignUpState createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  bool isSignUp = false;
  bool isCreateAcc = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: loginSignUpColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("images/logo.png",height: 100,width: 100,fit: BoxFit.fill,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "In the comfort of your home",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Not sure exactly what you need? Want to talk in general to the therapist to find out more in an introductory session? Haven’t got a suitable place to talk? Metis experts totally get it, they’ll adapt your session around you",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              Column(
                children: [
                  MaterialButton(
                    height: 50,
                    shape: StadiumBorder(),
                    color: Color(0xff3b5998),
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (ctx) {
                          return FbBottomSheet();
                        });
                    },
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
                    onPressed: () async{
                      final credential = await SignInWithApple.getAppleIDCredential(
                        scopes: [
                          AppleIDAuthorizationScopes.email,
                          AppleIDAuthorizationScopes.fullName,
                        ],
                        webAuthenticationOptions: WebAuthenticationOptions(
                          clientId:
                          'com.aboutyou.dart_packages.sign_in_with_apple.example',
                          redirectUri: Uri.parse(
                            'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
                          ),
                        ),
                        nonce: 'example-nonce',
                        state: 'example-state',
                      );
                      print(credential);
                      final signInWithAppleEndpoint = Uri(
                        scheme: 'https',
                        host: 'flutter-sign-in-with-apple-example.glitch.me',
                        path: '/sign_in_with_apple',
                        queryParameters: <String, String>{
                          'code': credential.authorizationCode,
                          if (credential.givenName != null)
                            'firstName': credential.givenName!,
                          if (credential.familyName != null)
                            'lastName': credential.familyName!,
                          'useBundleId':
                          Platform.isIOS || Platform.isMacOS ? 'true' : 'false',
                          if (credential.state != null) 'state': credential.state!,
                        },
                      );
                      final session = await http.Client().post(
                        signInWithAppleEndpoint,
                      );
                      print(session);
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: MaterialButton(
                            height: 50,
                            shape: StadiumBorder(),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()));
                            },
                            child: Text("Sign in")),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: MaterialButton(
                            height: 50,
                            shape: StadiumBorder(),
                            color: Colors.yellow,
                            onPressed: () {
                              // _logOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateAccount()));
                            },
                            child: Text("Create Account")),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
