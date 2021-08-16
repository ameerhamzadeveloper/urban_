import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:urban/constants.dart';
import 'package:urban/customerApp/services/book_service.dart';
import 'package:urban/customerApp/services/home_page_services.dart';
import 'package:urban/customerApp/services/payment_service.dart';
import 'package:urban/customerApp/services/stripe_charge.dart';
class ProviderDetails extends StatefulWidget {
  @override
  _ProviderDetailsState createState() => _ProviderDetailsState();
}

class _ProviderDetailsState extends State<ProviderDetails> with TickerProviderStateMixin{
  bool isAdded = false;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<HomePageServices>(context);
    final bookPro = Provider.of<BookService>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // Add the app bar to the CustomScrollView.
          SliverAppBar(
            actions: [
              IconButton(
                color: isAdded ? Colors.red : Colors.white,
                icon: Icon(Icons.favorite),
                onPressed: (){
                  setState(() {
                    isAdded = !isAdded;
                  });
                  pro.addToFavorite(context, pro.providerServices!.serviceId.toString());
                },
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: pro.providerServices!.profileImage == null ? page2Color : Colors.transparent,
                    border: Border.all(
                      width: 3,
                      color: kProfileCircleBorderColor
                    ),
                    shape: BoxShape.circle
                  ),
                  child:pro.providerServices!.profileImage != null ? ClipOval(
                    child: Image.network(
                      pro.providerServices!.profileImage ?? "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                      fit: BoxFit.cover,
                      height: 70,
                      width: 70,
                    ),

                    // this need to change for provider avatar code
                    //   pro.providerServices!.firstName!.substring(0,1).toUpperCase()
                  ) : Center(child: Text(pro.providerServices!.firstName!.substring(0,1).toUpperCase(),style: TextStyle(fontSize: 42,fontWeight: FontWeight.bold),),),
                ),
                background: Image.network(
                  pro.providerServices!.serviceImage ?? "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                  fit: BoxFit.cover,
                )),
            // Provide a standard title.
            title: Text(pro.providerServices!.serviceName ?? "Loading...",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
            // Allows the user to reveal the app bar if they begin scrolling
            // back up the list of items.
            floating: true,
            // Make the initial height of the SliverAppBar larger than normal.
            expandedHeight: 200,
          ),
          SliverFillRemaining(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(pro.providerServices!.firstName ?? "Loading...",style: TextStyle(fontSize: 42,fontWeight: FontWeight.bold),),
                         Row(
                           children: [
                             Icon(Icons.star,color: Colors.yellow,),
                             Text("4.9")
                           ],
                         )
                       ],
                     ),
                    DefaultTabController(
                        length: 2, // length of tabs
                        initialIndex: 0,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                          Container(
                            child: TabBar(
                              indicatorColor: kProfileCircleBorderColor,
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                Tab(text: 'About'),
                                Tab(text: 'Reviews'),
                              ],
                            ),
                          ),
                          Container(
                              height: 400, //height of TabBarView
                              decoration: BoxDecoration(
                                  border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                              ),
                              child: TabBarView(children: <Widget>[
                                Container(
                                  child: Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10,),
                                      Text("Description",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 10,),
                                      Text(pro.providerServices!.serviceDescription ?? ""),
                                      SizedBox(height: 10,),
                                      // Text("See on map",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                      // SizedBox(height: 10,),
                                      // Container(
                                      //   height: MediaQuery.of(context).size.height / 3,
                                      //   decoration: BoxDecoration(
                                      //     border: Border.all(color: Colors.yellowAccent),
                                      //   ),
                                      //   child: GoogleMap(
                                      //     initialCameraPosition:
                                      //     CameraPosition(target: latLng, zoom: 11.0),
                                      //     onCameraMove: onCameraMove,
                                      //     onMapCreated: onMapCreated,
                                      //     mapType: MapType.normal,
                                      //     markers: markers,
                                      //   ),
                                      // ),
                                    ],
                                  )
                                ),
                                Container(
                                  child: Center(
                                    child: Text('No Reviews Yet', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ])
                          )
                        ])
                    ),
                  ],
                ),
              )
            ],
          ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 60),
        child: MaterialButton(
          // minWidth: MediaQuery.of(context).size.width - ,
          shape: StadiumBorder(),
          height: 40,
          color: kButtonColor,
          onPressed: (){
            if(Platform.isAndroid){
              print("card");
              StripeCharge.addNewCard(context,"1200", "USD");
            }else{
              StripePayment.paymentRequestWithNativePay(
                androidPayOptions: AndroidPayPaymentRequest(
                  totalPrice: "1.20",
                  currencyCode: "USD",
                ),
                applePayOptions: ApplePayPaymentOptions(
                  countryCode: 'US',
                  currencyCode: 'USD',
                  items: [
                    ApplePayItem(
                      label: 'New Service',
                      amount: '13',
                    )
                  ],
                ),
              ).then((token) {
                print(token.card!.token);
              });
            }

            bookPro.bookService(context);
          },
          child: Text("Book Now",style: TextStyle(fontSize: 22,color: Colors.black),),
        ),
      )
    );
  }
}
