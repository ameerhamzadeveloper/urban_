import 'package:flutter/material.dart';
import 'package:urban/constants.dart';
import 'package:urban/providerApp/bookings/current_booking.dart';

import 'past_bookings.dart';
class ProviderBookings extends StatefulWidget {
  @override
  _ProviderBookingsState createState() => _ProviderBookingsState();
}

class _ProviderBookingsState extends State<ProviderBookings> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Bookings"),
          bottom: TabBar(
            indicatorColor: kProfileCircleBorderColor,
            tabs: [
              Tab(child: Text("Current",style: TextStyle(color: Colors.black),),),
              Tab(child: Text("Past",style: TextStyle(color: Colors.black),),)
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ProviderCurrentBooking(),
            ProviderPastBookings()
          ],
        ),
      ),
    );
  }
}