import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/customerApp/services/home_page_services.dart';
import 'package:urban/customerApp/shimmer_widgets/home_page_shimmer.dart';
import 'package:urban/customerApp/views/providers_screen.dart';

class SubCategoryScreen extends StatefulWidget {
  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<HomePageServices>(context);
    String des = "Book online mental healthcare, in the comfort of your own home";
    return Scaffold(
      backgroundColor: Colors.white,
      body: pro.subCategories!.length == 0
          ? SubCategoryShimmer()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Online",
                      style:
                          TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      des,
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: pro.subCategories!.length == 0 ? 0 : pro.subCategories!.length,
                    itemBuilder: (ctx, i) {
                      var subCat = pro.subCategories?[i];
                      return Container(
                        height: 400,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProvidersScreen(),
                                ));
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 130,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(subCat!
                                              .subcategoryImage ??
                                              "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg"),
                                        ),
                                      ),
                                    ),
                                    Text(subCat.subcategoryName!.toString(),style: TextStyle(fontSize: 18),textAlign: TextAlign.justify,),
                                    // subCat.subcategoryName!.length > 29 ? subCat.subcategoryName!.substring(0,30) :
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
