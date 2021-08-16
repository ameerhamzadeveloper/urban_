import 'package:flutter/material.dart';
import 'package:urban/constants.dart';
class IncomingAudioCall extends StatefulWidget {
  @override
  _IncomingAudioCallState createState() => _IncomingAudioCallState();
}

class _IncomingAudioCallState extends State<IncomingAudioCall> {
  bool isRedPress = false;
  bool isGreenPress = false;
  @override
  Widget build(BuildContext context) {
    var ratio = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: ratio.width,
        height: ratio.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              page1Color,
              page2Color,
              page3Color
            ]
          )
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              Column(
                children: [
                  Text("Incoming Call",style: TextStyle(fontSize: 22,color: Colors.white),),
                  SizedBox(height: 10,),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: kProfileCircleBorderColor,width: 3)
                    ),
                    child: Center(
                      child: Text("AH",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("Ameer Hamza",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),)
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left:40.0,right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap:(){
                        setState(() {
                          isRedPress = !isRedPress;
                        });
                        Future.delayed(Duration(milliseconds: 100),(){
                          setState(() {
                            isRedPress = !isRedPress;
                          });
                        });
                      },
                      child: Container(
                        height: isRedPress ? 60 :70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Icon(Icons.call_end),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.grey,
                      highlightColor: Colors.grey,
                      hoverColor: Colors.grey,
                      onTap: (){
                        setState(() {
                          isGreenPress = !isGreenPress;
                        });
                        Future.delayed(Duration(milliseconds: 100),(){
                          setState(() {
                            isGreenPress = !isGreenPress;
                          });
                        });
                      },
                      child: Container(
                        height: isGreenPress ? 60 :70,
                        width: 70,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Icon(Icons.call),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
