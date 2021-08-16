
import 'package:flutter/material.dart';
import 'package:urban/constants.dart';
import 'package:urban/customerApp/views/bookings/current_booking.dart';
import 'package:urban/customerApp/views/bookings/past_bookings.dart';
class Bookings extends StatefulWidget {
  
  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bookings"),
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
            CurrentBookings(),
            PastBookings()
          ],
        )
      ),
    );
  }
}