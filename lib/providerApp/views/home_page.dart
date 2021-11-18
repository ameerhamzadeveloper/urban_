import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:urban/constants.dart';
import 'package:urban/customerApp/views/bottom_nav_bar.dart';
import 'package:urban/customerApp/views/login_signup.dart';
import 'package:urban/providerApp/bookings/bookings.dart';
import 'package:urban/providerApp/services/dashboard.dart';
import 'package:urban/providerApp/services/service.dart';
import 'package:urban/providerApp/views/help.dart';
import 'package:urban/providerApp/views/how_it_work.dart';
import 'package:urban/providerApp/views/privacy_policy.dart';
import 'package:urban/providerApp/views/profile.dart';
import 'package:urban/providerApp/views/services/services_screen.dart';
import 'package:urban/providerApp/views/wallet/wallet.dart';
import 'package:urban/services/sign_in_sign_up.dart';

class ProviderHomePage extends StatefulWidget {
  @override
  _ProviderHomePageState createState() => _ProviderHomePageState();
}

class _ProviderHomePageState extends State<ProviderHomePage> {
  bool isSeller = false;
  @override
  void initState() {
    super.initState();
    final pro = Provider.of<SignInSignUpProvider>(context,listen: false);
    final proo = Provider.of<Services>(context,listen: false);
    final prood = Provider.of<DashBoard>(context,listen: false);
    // final prob = Provider.of<BookService>(context,listen: false);
    pro.getFromSharedPref();
    proo.getUserId();
    prood.fetchDashboardData(context);
    Future.delayed(Duration(seconds: 5),(){
      proo.fetchServices(context);
      proo.fetchCurrentBooked(context);
      proo.fetchPastBooking(context);
    });
  }
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final proo = Provider.of<Services>(context);
    final pro = Provider.of<SignInSignUpProvider>(context);
    final prood = Provider.of<DashBoard>(context);
    // final prooh = Provider.of<HomePageServices>(context);
    return Scaffold(
      drawer: Drawer(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 6,color: kProfileCircleBorderColor)
                ),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: page2Color,
                  child: Text("${pro.sHuserFirst!.substring(0,1).toUpperCase()}${ pro.sHuserLast!.length > 0 ? pro.sHuserLast!.substring(0,1).toUpperCase() : ""}" ,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                pro.sHuserFirst != '' ? "${pro.sHuserFirst} ${pro.sHuserLast!.length > 0 ? pro.sHuserLast : ""}" : "Loading...",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 2,
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (contet) => BottomNavBar()
                  ));
                },
                title: Text("Switch to Patient"),
                leading: Icon(Icons.switch_account),
                trailing: Switch(
                  value: isSeller,
                  activeColor: Colors.black,
                  onChanged: (val) {
                    setState(() {
                      isSeller = !isSeller;
                    });
                    if(val == true){
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavBar()),(route) => false);
                    }
                  },
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProviderProfile()));
                },
                leading: Icon(Icons.person),
                title: Text("Profile"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProviderBookings()));
                },
                leading: Icon(Icons.book_online),
                title: Text("Bookings"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProviderBookings()));
                },
                leading: Icon(WebSymbols.chat),
                title: Text("Messages"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyPolicy()));
                },
                leading: Icon(Icons.privacy_tip),
                title: Text("Privacy Policy"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProviderWallet()));
                },
                leading: Icon(FontAwesome5.wallet),
                title: Text("Wallet"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HowItWork()));
                },
                leading: Icon(Icons.work_outline),
                title: Text("How It Works"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Help()));
                },
                leading: Icon(Icons.help),
                title: Text("Help"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              MaterialButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx){
                      return AlertDialog(
                        title: Text("Are you sure you want to logout?"),
                        clipBehavior: Clip.antiAlias,
                        // content: Text("if you logout your account you need to sign in again"),
                        actions: [
                          TextButton(
                            onPressed:(){
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed:()async{
                              await pro.logOutFromShared();
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginSignUp()), (route) => false);
                            },
                            child: Text("Logout"),
                          )
                        ],
                      );
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("LogOut"), Icon(Icons.exit_to_app)],
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: loginSignUpColor,
        title: Text(
          "Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                if(proo.services.length <= 0){
                  proo.fetchServices(context);
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ServicesScreen()));
              },
              icon: Icon(Typicons.popup))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Weekly Report",
                style: TextStyle(color: Colors.green),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 120,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(kPundSign,style: TextStyle(fontSize: 20),),
                              Text(
                                "Earnings",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Text(
                            "$kPundSign${prood.earnings}",
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 120,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Completed",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Text(
                            prood.completed,
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 120,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Rating",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            prood.rating,
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 120,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Cancel",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            prood.cancel,
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProviderBookings()));
              },
              child: Container(
                height: 120,
                child: Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Current",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            prood.current,
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Earnings"),
            ),
            Expanded(
          child: SfCartesianChart(
            // Initialize category axis
            primaryXAxis: CategoryAxis(),
            series: <LineSeries<SalesData, String>>[
              LineSeries<SalesData, String>(
                // Bind data source
                dataSource:  <SalesData>[
                  SalesData('Sat', 10),
                  SalesData('Sun', 20),
                  SalesData('Mon', 34),
                  SalesData('Teu', 32),
                  SalesData('Wed', 40),
                  SalesData('Thu', 35),
                  SalesData('Fri', 49)
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales
              )
            ]
          )
        )
          ],
        ),
      ),
    );
  }
}
class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}