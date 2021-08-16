import 'package:flutter/material.dart';
class Payment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
