import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
class ProviderWallet extends StatefulWidget {
  @override
  _ProviderWalletState createState() => _ProviderWalletState();
}

class _ProviderWalletState extends State<ProviderWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Add new payment method",style: TextStyle(fontSize: 18),),
                Container(
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        shape: BoxShape.circle
                    ),
                    child: Center(child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward))))
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget oldWalletDesign(BuildContext context){
  return Column(
    children: [
      CreditCardWidget(
        cardNumber: "2424242424242",
        expiryDate: "12/24",
        cardHolderName: "Provider Wallet",
        cvvCode: "231",
        textStyle: TextStyle(color: Colors.yellowAccent,fontSize: 20),
        width: MediaQuery.of(context).size.width,
        animationDuration: Duration(milliseconds: 1000),
        showBackView: false, //true when you want to show cvv(back) view
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Recent Transactions"),
              ),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 10.0,
                child: ListTile(
                  title: Text("\$280"),
                  subtitle: Text("Massage Service"),
                  trailing: Text("12-06-2021"),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 10.0,
                child: ListTile(
                  title: Text("\$780"),
                  subtitle: Text("Handyman Service"),
                  trailing: Text("12-06-2021"),
                ),
              )
            ]
        ),
      )
    ],
  );
}