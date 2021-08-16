import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/constants.dart';
import 'package:urban/customerApp/services/book_service.dart';
import 'package:urban/customerApp/shimmer_widgets/booking_shimmer_widget.dart';
class CurrentBookings extends StatefulWidget {
  @override
  _CurrentBookingsState createState() => _CurrentBookingsState();
}

class _CurrentBookingsState extends State<CurrentBookings> {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<BookService>(context);
    return Scaffold(
      body: pro.currentBook!.length == 0 ?  Container(
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
      ):
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
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
            ),
          ),
    );
  }
}
class NoBookingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 5),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Container(
          child: Column(
            children: [
              Container(
                height: 50,
                color: Colors.grey,
              ),
              SizedBox(height: 10,),
              Container(
                height: 10,
                width: 130,
                color: Colors.grey,
              ),
              SizedBox(height: 10,),
              Container(
                height: 5,
                color: Colors.grey,
              ),
              SizedBox(height: 3,),
              Container(
                height: 5,
                color: Colors.grey,
              ),
              // SizedBox(height: 10,),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //       height: 10,
              //       width: 100,
              //       color: Colors.grey,
              //     ),
              //     Container(
              //       height: 10,
              //       width: 100,
              //       color: Colors.grey,
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
