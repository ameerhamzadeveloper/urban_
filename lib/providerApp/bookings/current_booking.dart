import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/customerApp/services/book_service.dart';
import 'package:urban/customerApp/shimmer_widgets/booking_shimmer_widget.dart';
class ProviderCurrentBooking extends StatefulWidget {
  @override
  _ProviderCurrentBookingState createState() => _ProviderCurrentBookingState();
}

class _ProviderCurrentBookingState extends State<ProviderCurrentBooking> {
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<BookService>(context);
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: pro.isCurrentFetching ?  BookingShimmerWidgets().currentBookingShimmerList():
          ListView.builder(
            itemCount: pro.currentBook != null ? pro.currentBook!.length : 0,
            itemBuilder: (ctx,i){
              if(pro.currentBook!.length > 0){
                return Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Column(
                        children: [
                          Image.network("${pro.currentBook?[i].serviceImage}"),
                          SizedBox(height: 10,),
                          Text(pro.currentBook?[i].serviceName ?? "",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Text(pro.currentBook?[i].serviceDescription ?? ""),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(pro.currentBook?[i].bookingDate ?? "",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(pro.currentBook?[i].bookingStartTime ?? "",style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }else{
                return Center(
                  child: Text("No Current Booking"),
                );
              }
            },
          )
      ),
    );
  }
}