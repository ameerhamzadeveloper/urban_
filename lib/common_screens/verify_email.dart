import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:urban/constants.dart';
import 'package:urban/services/sign_in_sign_up.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<SignInSignUpProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          pro.isVerifyPressed
              ? SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(
                      color: Colors.redAccent,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                )
              : Container(),
          Form(
            key: form,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("images/verifyEmail.gif"))),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Verify your email",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Please enter the 6 digit code sent to\n${pro.emailCont.text}",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 40),
                    child: Container(
                      child: PinCodeTextField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please Enter Code";
                          }
                        },
                        appContext: context,
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          inactiveColor: kProfileCircleBorderColor,
                          inactiveFillColor: kProfileCircleBorderColor,
                          selectedColor: page1Color,
                          selectedFillColor: page1Color,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        enableActiveFill: true,
                        onCompleted: (v) {
                          pro.verifyEmail(context);
                        },
                        onChanged: (value) {
                          pro.verificationCode = value;
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          return true;
                        },
                      ),
                    ),
                  ),
                  pro.authError != ''
                      ? Text(
                          pro.authError,
                          style: TextStyle(color: Colors.red),
                        )
                      : Container(),
                  TextButton(
                    child: Text("Resend code",style: TextStyle(color: page1Color),),
                    onPressed: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      height: 40,
                      color: kButtonColor,
                      minWidth: MediaQuery.of(context).size.width,
                      shape: StadiumBorder(),
                      onPressed: () {
                        pro.makeErrorNull();
                        if (form.currentState!.validate()) {
                          pro.verifyEmail(context);
                          pro.makeVerify();
                        }
                      },
                      child: Text(
                        "Confirm",
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
