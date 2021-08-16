import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:urban/customerApp/views/bookings/bookings.dart';
import 'package:urban/customerApp/views/favorite.dart';
import 'package:urban/customerApp/views/home_page.dart';
import 'package:urban/customerApp/views/more/more.dart';
import 'package:urban/incoming_audio_call.dart';
import 'package:urban/services/local_notification_services.dart';


class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> allScreens = [
    HomePage(),
    Bookings(),
    // Refer(),
    Favorite(),
    More()
  ];
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalNotificationService.initialize(context);

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification != null){
        print(message.data['call']);
        print(message.notification!.title);
        if(message.data['call'] == 'audio'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => IncomingAudioCall()));
        }
        LocalNotificationService.display(message);
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: allScreens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        currentIndex: currentIndex,
        onTap: (ind){
          setState(() {
            currentIndex = ind;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Booking"
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(FontAwesome5.gift),
          //   label: "Refer"
          // ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesome5.heart),
            label: "Favorites"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_sharp),
            label: "More"
          )
        ],
      ),
    );
  }
}