import 'package:flutter/material.dart';

class IntroItem extends StatelessWidget {
  final int currentPage;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color textColor;
  final Color subTitleColor;
  IntroItem(this.currentPage,this.icon,this.subtitle,this.title,this.color,this.textColor,this.subTitleColor);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: color,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("images/logo.png",height: 100,width: 100,fit: BoxFit.fill,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: textColor),),
              SizedBox(height: 20,),
              Text(subtitle,style: TextStyle(color: subTitleColor,fontSize: 18),),
                ],
              ),
              SizedBox(height: 30,),
              Container()
            ],
          ),
        ),
      ),
    );
  }
}