import 'package:flutter/material.dart';
import 'package:urban/constants.dart';
import 'package:urban/customerApp/views/check_email.dart';
class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/post_box.png"),
              SizedBox(height: 20,),
              Text("Forgot Your Password",style: TextStyle(fontSize: 22,color: Colors.black),),
              SizedBox(height: 10,),
              Text("Enter your registered email below to receive reset password code",style: TextStyle(color: Colors.grey),),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Your Email",
                    border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(height: 30,),
              MaterialButton(
                minWidth: double.infinity,
                color: kButtonColor,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CheckEmail()));
                },
                child: Text("Send"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
