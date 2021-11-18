import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../../constants.dart';
class CreditBuyer extends StatefulWidget {
  @override
  _CreditBuyerState createState() => _CreditBuyerState();
}

class _CreditBuyerState extends State<CreditBuyer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("You have no credit",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
              Text("Refer your friends now for the chance to win a free credit’"),
              MaterialButton(
                color: Colors.grey[300],
                shape: StadiumBorder(),
                onPressed: (){
                  Share.share("metis");
                },
                child: Text("Refer now"),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: MaterialButton(
              height: 50,
              minWidth: MediaQuery.of(context).size.width,
              color: kButtonColor,
              shape: StadiumBorder(),
              onPressed: (){},
              child: Text("Add credit"),
            ),
          )
        ],
      ),
    );
  }
}
