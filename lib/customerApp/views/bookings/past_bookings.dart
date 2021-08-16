import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/constants.dart';
import 'package:urban/customerApp/services/book_service.dart';
import 'package:urban/customerApp/views/bookings/current_booking.dart';
class PastBookings extends StatefulWidget {
  @override
  _PastBookingsState createState() => _PastBookingsState();
}

class _PastBookingsState extends State<PastBookings> {
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<BookService>(context);
    return Scaffold(
      body: pro.pastBooking!.length == 0 ? Container(
        color: Colors.grey[300],
        child: Column(
          children: [
            NoBookingWidget(),
            NoBookingWidget(),
            NoBookingWidget(),
            SizedBox(height: 40,),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("You haven't booked yet",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),),
                      SizedBox(height: 20,),
                      Text("You don't have any upcomming bookings to display",style: TextStyle(color: Colors.grey),),
                      SizedBox(height: 20,),
                      MaterialButton(
                        shape: StadiumBorder(),
                        minWidth: MediaQuery.of(context).size.width,
                        color: kButtonColor,
                        onPressed: (){},
                        child: Text("Book now"),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ):Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: pro.pastBooking != null ? pro.pastBooking!.length : 0,
          itemBuilder: (ctx,i){
            var pr = pro.pastBooking?[i];
            if(pro.pastBooking!.length > 0){
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                elevation: 15.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    leading: Image.network(pr?.serviceImage ?? kSampleImage,height: 120,width: 80,fit: BoxFit.cover,),
                    title: Text(pr?.serviceName ?? "Loading..."),
                    subtitle: Text(pr?.serviceDescription ?? "Loading...""Personal Massage Service"),
                    trailing: Text(pr?.bookingDate ?? "Loading..."),
                  ),
                ),
              );
            }else{
              return Center(
                child: Text("No Past Bookings"),
              );
            }
          },
        )
      ),
    );
  }
}