import 'package:flutter/material.dart';
import 'package:urban/customerApp/views/more/credit.dart';
import 'package:urban/customerApp/views/more/payment.dart';

import '../../../constants.dart';
class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,color: Colors.black,),
            ),
            actions: [
              // IconButton(onPressed: (){}, icon: Icon(Icons.info,color: Colors.grey,))
            ],
            title: Text("Wallet"),
            bottom: TabBar(
              labelColor: Colors.black,
              indicatorColor: kProfileCircleBorderColor,
              tabs: [
                Tab(
                  text: "PAYMENT",
                ),
                Tab(
                  text: "CREDIT",
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              PaymentBuyer(),
              CreditBuyer()
            ],
          )
      ),
    );
  }
}