import 'package:flutter/material.dart';
class Refer extends StatefulWidget {
  @override
  _ReferState createState() => _ReferState();
}

class _ReferState extends State<Refer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refer"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("Give Us a try first",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Text("You need to have at least one booking before you start to refering your friend"),
                  SizedBox(height: 30,),
                  MaterialButton(
                    height: 40,
                    minWidth: MediaQuery.of(context).size.width,
                    shape: StadiumBorder(),
                    color: Colors.yellow,
                    onPressed: (){},
                    child: Text("Book Now"),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}