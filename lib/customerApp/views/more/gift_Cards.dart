import 'package:flutter/material.dart';
import 'package:urban/constants.dart';
import 'package:urban/customerApp/views/more/gift_card_bottom_sheet.dart';
class GiftCards extends StatefulWidget {
  @override
  _GiftCardsState createState() => _GiftCardsState();
}

class _GiftCardsState extends State<GiftCards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(kPundSign,style: TextStyle(fontSize: 22)),
                          Text("32",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 52),)
                        ],
                      ),
                    ),
                    Align(
                      child: Image.asset("images/logo.png",height: 150,),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15)
                            ),
                          ),
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => Container(
                            height: MediaQuery.of(context).size.height - 100,
                            color: Colors.transparent,
                            // padding: EdgeInsets.only(
                            //     bottom: MediaQuery.of(context)
                            //         .viewInsets
                            //         .bottom),
                            child: GiftCardBottomSheet(),
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choose a voucher"),
                          Text("$kPundSign 50 - gift voucher"),
                          Icon(Icons.keyboard_arrow_down_sharp)
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      height: 50,
                      minWidth: MediaQuery.of(context).size.width,
                      color: kButtonColor,
                      shape: StadiumBorder(),
                      onPressed: (){},
                      child: Text("Next"),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
