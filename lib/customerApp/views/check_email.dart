import 'package:flutter/material.dart';
import 'package:urban/customerApp/views/sign_in.dart';
class CheckEmail extends StatefulWidget {
  @override
  _CheckEmailState createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            SizedBox(height: 20,),
            Text("Check your email",style: TextStyle(fontSize: 22,color: Colors.black),),
            SizedBox(height: 10,),
            Text("We have sent password recovery instructions to your email",style: TextStyle(color: Colors.grey),),
            SizedBox(height: 30,),
            MaterialButton(
              minWidth: double.infinity,
              color: Colors.yellowAccent,
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
              },
              child: Text("Ok"),
            )
          ],
        ),
      ),
    );
  }
}
