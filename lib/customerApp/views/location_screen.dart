import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:urban/customerApp/views/select_city.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Where do you want your appointment?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  "This will help us match you with urban pros in your time zone"),
              SizedBox(
                height: 30,
              ),
              Text(
                "Enter Address \nor postal code",
                style: TextStyle(color: Colors.grey),
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                height: 50,
                shape: StadiumBorder(),
                color: Colors.grey[200],
                onPressed: () async {
                  //  await Permission.location.request();
                   Navigator.push(context, MaterialPageRoute(builder: (context) => SelectCity()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(FontAwesome5.location_arrow),
                    Text("Find my location"),
                    Container()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
