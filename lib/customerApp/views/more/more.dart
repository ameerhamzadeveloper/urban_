import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban/constants.dart';
import 'package:urban/customerApp/views/more/about_app.dart';
import 'package:urban/customerApp/views/more/account_settings.dart';
import 'package:urban/customerApp/views/more/emergency_resources.dart';
import 'package:urban/customerApp/views/more/faq.dart';
import 'package:urban/customerApp/views/more/gift.dart';
import 'package:urban/customerApp/views/more/messages.dart';
import 'package:urban/customerApp/views/more/wallet.dart';
import 'package:urban/customerApp/views/support.dart';
import 'package:urban/providerApp/views/home_page.dart';
import 'package:urban/services/sign_in_sign_up.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  bool isSeller = false;
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<SignInSignUpProvider>(context);
    // final proh = Provider.of<HomePageServices>(context);
    return Scaffold(
        // backgroundColor: Colors.redAccent,
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: loginSignUpColor,
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: pro.sHuserFirst != null ?  Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 3, color: kProfileCircleBorderColor)),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: page2Color,
                                  child: Text(
                                    "${pro.sHuserFirst!.substring(0, 1).toUpperCase()} ${pro.sHuserLast!.length > 0 ? pro.sHuserLast!.substring(0, 1).toUpperCase() : ""}",
                                    style:
                                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
                                  ),
                                ),
                              ): ClipOval(
                                child: Image.asset(
                                  "images/profile.jpeg",
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  pro.sHuserFirst == null ? "" : "${pro.sHuserFirst}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  pro.sHuserLast != null ? "" : "${pro.sHuserLast}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              pro.sHuserEmail ?? "Loading...",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () async{
                                // print(pro.sHuserid);
                                Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountSettings()));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.arrow_forward_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  )),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ListTile(
          onTap: () {},
          title: Text("Switch to Practitioner"),
          leading: Icon(Entypo.switch_icon),
          trailing: Switch(
        value: isSeller,
        activeColor: Colors.black,
        onChanged: (val) async{
          setState(() {
            isSeller = !isSeller;
          });
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ProviderHomePage()),(route) => false);
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString('provider', "Yes");
          if (val == true) {
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => ProviderHomePage()));
          }
        },
          ),
        ),
        Divider(),
        MoreItemComponents(
          () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Wallet()));
          },
          "Wallet",
          Linecons.wallet,
        ),
        MoreItemComponents(
          () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Messages()));
          },
          "Messages",
          WebSymbols.chat,
        ),
        MoreItemComponents(
          () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Gift()));
          },
          "Gift cards",
          Typicons.gift,
        ),
        MoreItemComponents(
          () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EmergencyResources()));
          },
          "Emergency resources",
          FontAwesome5.building,
        ),
        MoreItemComponents(
          () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Support()));
          },
          "Support",
          Icons.support,
        ),
        MoreItemComponents(
          () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AboutApp()));
          },
          "About the app",
          Icons.info,
        ),
          MoreItemComponents(
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FAQ()));
                },
            "FAQ",
            Icons.help,
          )
        ],
      ),
    ));
  }
}

class MoreItem {
  String name;
  IconData icon;
  Function onTap;
  MoreItem(this.icon, this.name, this.onTap);
}

List<MoreItem> moreItemList = [
  MoreItem(Icons.wallet_giftcard, "Wallet", () {}),
  MoreItem(Icons.wallet_giftcard, "Messages", () {}),
  MoreItem(Icons.wallet_giftcard, "Gift cards", () {}),
  MoreItem(Icons.wallet_giftcard, "Corporate wellness", () {}),
  MoreItem(Icons.wallet_giftcard, "My addresses", () {}),
  MoreItem(Icons.wallet_giftcard, "Support", () {}),
  MoreItem(Icons.wallet_giftcard, "About the app", () {}),
];

class MoreItemComponents extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  final IconData icon;
  MoreItemComponents(this.onTap, this.name, this.icon);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(name),
          leading: Icon(icon),
          trailing: InkWell(
            onTap: onTap,
            child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, border: Border.all(color: Colors.grey)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.black,
                    size: 20,
                  ),
                )),
          ),
        ),
        Divider()
      ],
    );
  }
}
