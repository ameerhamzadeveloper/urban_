import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/constants.dart';
import 'package:urban/customerApp/services/home_page_services.dart';
class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<HomePageServices>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: pro.favServices?.data?.length,
          itemBuilder: (ctx,i){
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: Image.network(pro.favServices?.data?[i].serviceImage ?? "https://miro.medium.com/max/700/0*H3jZONKqRuAAeHnG.jpg",fit: BoxFit.fill,)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                            backgroundColor: kProfileCircleBorderColor,
                            child: Icon(Icons.favorite,color: Colors.white,)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(pro.favServices?.data?[i].serviceName ?? "Loading....",style: TextStyle(color: kProfileCircleBorderColor),),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      )
    );
  }
}