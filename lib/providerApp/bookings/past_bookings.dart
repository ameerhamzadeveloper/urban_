import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/constants.dart';
import 'package:urban/customerApp/services/book_service.dart';
class ProviderPastBookings extends StatefulWidget {
  @override
  _ProviderPastBookingsState createState() => _ProviderPastBookingsState();
}

class _ProviderPastBookingsState extends State<ProviderPastBookings> {
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<BookService>(context);
    return Scaffold(
      body: Padding(
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