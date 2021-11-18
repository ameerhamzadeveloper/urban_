
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/customerApp/services/book_service.dart';
import 'package:urban/customerApp/services/home_page_services.dart';
import 'package:urban/customerApp/services/profile_services.dart';
import 'package:urban/incoming_audio_call.dart';
import 'package:urban/providerApp/services/dashboard.dart';
import 'package:urban/providerApp/services/service.dart';
import 'package:urban/routes/routes_names.dart';
import 'package:urban/services/sign_in_sign_up.dart';
import 'package:urban/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();


///Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async{
  print(message.data.toString());
  String ringing = "ring.mp3";

  // print(message.notification!.title);
  if(message.data['call'] == 'audio'){

    navigatorKey.currentState!.pushNamed(audioIncomming);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then((message)async{
      if(message != null){
        String ringing = "ring.mp3";

        if(message.data['call'] == 'audio'){

          Navigator.push(context, MaterialPageRoute(builder: (context) => IncomingAudioCall()));
        }
      }
    });
    ///forground work
    FirebaseMessaging.onMessage.listen((message) async{
      if(message.notification != null){
        // print(message.data['call']);
        // print(message.notification!.title);
        String ringing = "ring.mp3";
        if(message.data['call'] == 'audio'){

          Navigator.push(context, MaterialPageRoute(builder: (context) => IncomingAudioCall()));
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async{
      String ringing = "ring.mp3";

      if(message.notification != null){

        // print(message.data['call']);
        // print(message.notification!.title);
        if(message.data['call'] == 'audio'){

          Navigator.push(context, MaterialPageRoute(builder: (context) => IncomingAudioCall()));
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignInSignUpProvider>(
          create: (context) => SignInSignUpProvider(),
        ),
        ChangeNotifierProvider<Services>(
          create: (context) => Services(),
        ),
        ChangeNotifierProvider<CustomerProfileServices>(
          create: (context) => CustomerProfileServices(),
        ),
        ChangeNotifierProvider<HomePageServices>(
          create: (context) => HomePageServices(),
        ),
        ChangeNotifierProvider<BookService>(
          create: (context) => BookService(),
        ),
        ChangeNotifierProvider<DashBoard>(
          create: (context) => DashBoard(),
        ),
      ],
      child: MaterialApp(
        title: 'Metis',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            textTheme: TextTheme(
              headline6: TextStyle(color: Colors.black),
            ),
          ),
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
