import 'package:flutter/material.dart';
import 'package:urban/constants.dart';
import 'package:urban/customerApp/views/more/gift_Cards.dart';
import 'package:urban/customerApp/views/more/redeem.dart';
class Gift extends StatefulWidget {
  @override
  _GiftState createState() => _GiftState();
}

class _GiftState extends State<Gift> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,color: Colors.black,),
            ),
            title: Text("Gift Cards"),
            bottom: TabBar(
              labelColor: Colors.black,
              indicatorColor: kProfileCircleBorderColor,
              tabs: [
                Tab(
                  text: "Gift Card",
                ),
                Tab(
                  text: "Redeem",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GiftCards(),
              Radeem()
            ],
          ),
        ),
    );
  }
}
