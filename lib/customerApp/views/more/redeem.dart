import 'package:flutter/material.dart';
import 'package:urban/constants.dart';
class Radeem extends StatefulWidget {
  @override
  _RadeemState createState() => _RadeemState();
}

class _RadeemState extends State<Radeem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Enter Code"
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Credit on Account"),
                Text("$kPundSign 0.00")
              ],
            )
          ],
        ),
      ),
    );
  }
}
