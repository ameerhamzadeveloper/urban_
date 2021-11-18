import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban/customerApp/services/payment_service.dart';
import 'package:urban/customerApp/views/bottom_nav_bar.dart';
import 'package:urban/customerApp/views/intro.dart';
import 'package:urban/providerApp/views/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? provider;
  String? user;

  Future<void> intiFunction() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    provider = preferences.getString('provider');
    user = preferences.getString('user');
    StripeService.init();
    Future.delayed(Duration(seconds: 3), () {
      routeFunction();
      print(user);
      print(provider);
    });
  }

  void routeFunction() {
    if (provider == "Yes") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ProviderHomePage()));
    } else if (user == "Yes") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomNavBar()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => IntroPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    intiFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "images/icon.png",
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
