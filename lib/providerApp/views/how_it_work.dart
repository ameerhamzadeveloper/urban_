import 'package:flutter/material.dart';
class HowItWork extends StatefulWidget {
  @override
  _HowItWorkState createState() => _HowItWorkState();
}

class _HowItWorkState extends State<HowItWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Text("How it works: Become a Metis Therapist or Counsellor ",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Text("1. Complete your profile.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text("Give a comprehensive detailed description for what you do, why you can help, your specialisation, background, experience and approach. Fill out and explain your qualifications in full. Upload pictures of yourself and scans of qualifications. Add your payment details to receive payment."),
              SizedBox(height: 20,),
              Text("2. Set up your services.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text("Indicate your availability. Indicate whether you take corporate or business clients. Set your hourly rate. We suggest starting low to build up a client base and reputation and then increasing your rate as you get clients and feedback scores."),
              SizedBox(height: 20,),
              Text("3. Start your journey as a Metis therapist or counsellor today.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
            ],
          ),
        ),
      )
    );
  }
}
