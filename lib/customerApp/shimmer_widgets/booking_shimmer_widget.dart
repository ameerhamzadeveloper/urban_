import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BookingShimmerWidgets{
  Widget currentOrderWidget(){
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child: Shimmer.fromColors(
        direction: ShimmerDirection.ttb,
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 200,
                  color: Colors.grey,
                ),
                SizedBox(height: 10,),
                Container(
                  height: 20,
                  width: 130,
                  color: Colors.grey,
                ),
                SizedBox(height: 10,),
                Container(
                  height: 10,
                  color: Colors.grey,
                ),
                SizedBox(height: 3,),
                Container(
                  height: 10,
                  color: Colors.grey,
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 15,
                      width: 100,
                      color: Colors.grey,
                    ),
                    Container(
                      height: 15,
                      width: 100,
                      color: Colors.grey,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget currentBookingShimmerList(){
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (ctx,i){
        return currentOrderWidget();
      },
    );
  }
}