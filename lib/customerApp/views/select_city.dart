import 'package:flutter/material.dart';
import 'package:urban/customerApp/views/bottom_nav_bar.dart';

class SelectCity extends StatefulWidget {
  @override
  _SelectCityState createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.ac_unit_outlined,size: 60,color: Colors.white,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "In the comfort of your home",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Low on space or equipment? Urban expert totally get it.They'll adapt your session around your",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                                  height: 50,
                                  shape: StadiumBorder(),
                                  color: Colors.yellow,
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (ctx){
                                        return Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("SELECT YOUR CITY",style: TextStyle(fontSize: 18,color: Colors.grey),),
                                                SizedBox(height: 20,),
                                                InkWell(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("Manchester",style: TextStyle(fontSize: 18),),
                                                        Icon(Icons.circle_outlined,color: Colors.grey,)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Divider(),
                                                InkWell(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("Birmingham",style: TextStyle(fontSize: 18),),
                                                        Icon(Icons.circle_outlined,color: Colors.grey,)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Divider(),
                                                InkWell(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("London",style: TextStyle(fontSize: 18),),
                                                        Icon(Icons.circle_outlined,color: Colors.grey,)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Divider(),
                                                InkWell(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("Paris",style: TextStyle(fontSize: 18),),
                                                        Icon(Icons.circle_outlined,color: Colors.grey,)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Divider()
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    );
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => LocationScreen()));
                                  },
                                  child: Text("Select City"),
                                  ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}