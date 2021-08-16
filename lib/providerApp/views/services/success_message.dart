import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';
import 'package:urban/providerApp/services/service.dart';
import 'package:urban/providerApp/views/services/services_screen.dart';

class SuccessMessage extends StatefulWidget {
  @override
  _SuccessMessageState createState() => _SuccessMessageState();
}

class _SuccessMessageState extends State<SuccessMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff472DB3),
                      Color(0xffB464D1),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight
                  ),
                ),
              ),
            ),
            Positioned(
              top: 150,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.green,
                    child: Icon(Icons.check,size: 50,color: Colors.white,),
                  ),
                  SizedBox(height: 10,),
                  Text("Congratulations!",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                  Container(
                    width: 300,
                      child: Text("Your Work Service Successfully Published!",style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      shape: StadiumBorder(),
                      color: Colors.yellowAccent,
                      onPressed: ()async{
                        final proo = Provider.of<Services>(context,listen: false);
                        proo.services.clear();
                        await proo.fetchServices(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ServicesScreen()));
                      },
                      child: Text("Go to Service"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
