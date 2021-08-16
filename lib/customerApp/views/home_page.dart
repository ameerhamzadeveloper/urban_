import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/customerApp/services/book_service.dart';
import 'package:urban/customerApp/services/home_page_services.dart';
import 'package:urban/customerApp/shimmer_widgets/home_page_shimmer.dart';
import 'package:urban/customerApp/views/sub_category_page.dart';
import 'package:urban/services/sign_in_sign_up.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> init()async{
    final prov = Provider.of<SignInSignUpProvider>(context,listen: false);
    final prob = Provider.of<BookService>(context,listen: false);
    await prov.getFromSharedPref();
    // prob.currentFetch();
    await prob.fetchCurrentBooked(context);
    await prob.fetchPastBooking(context);
  }
  @override
  void initState() {
    super.initState();
    final pro = Provider.of<HomePageServices>(context, listen: false);
    pro.fetchCategoris();
    // pro.getLocation();
    init();
    Future.delayed(Duration(seconds: 5),(){
      pro.fetchFavoriteServices(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<HomePageServices>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Home"),
      ),
      body: pro.categories!.length == 0
          ? HomePageShimmer().shimmerCategory()
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: pro.categories == null ? 3 : 1,
                itemBuilder: (ctx, i) {
                  final categori = pro.categories?[i];
                  return InkWell(
                    onTap: () {
                      pro.getLocation();
                      pro.fetchSubCategoris(categori!.categoryId.toString());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SubCategoryScreen()));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              categori!.categoryImage ??
                                  "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
                              height: 230,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              categori.categoryName ?? "",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              categori.description ??
                                  "Book online mental healthcare, in the comfort of your own home",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
// Widget address(){
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       InkWell(
//         onTap: () {
//           showModalBottomSheet(
//               context: context,
//               builder: (ctx) {
//                 return Container(
//                   height: 300,
//                   child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Select an address",
//                           style:
//                           TextStyle(fontSize: 18, color: Colors.grey),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         InkWell(
//                           onTap: () {
//                             // Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Icon(Icons.location_on),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       "happy street,7",
//                                       style: TextStyle(fontSize: 18),
//                                     ),
//                                   ],
//                                 ),
//                                 Icon(
//                                   Icons.circle_outlined,
//                                   color: Colors.grey,
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         Divider(),
//                         InkWell(
//                           onTap: () {
//                             // Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Icon(Icons.home),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       "Manchester",
//                                       style: TextStyle(fontSize: 18),
//                                     ),
//                                   ],
//                                 ),
//                                 Icon(
//                                   Icons.circle_outlined,
//                                   color: Colors.grey,
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         Divider(),
//                         InkWell(
//                           onTap: () {
//                             // Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               // mainAxisAlignment: MainAxisAlignment.,
//                               children: [
//                                 Icon(
//                                   Icons.add,
//                                   color: Colors.black,
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text(
//                                   "Add new address",
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               });
//         },
//         child: Row(
//           children: [
//             Text("Home"),
//             Icon(
//               Icons.arrow_drop_down,
//               color: Colors.black,
//             ),
//           ],
//         ),
//       ),
//       SizedBox(
//         width: 33,
//       )
//     ],
//   );
// }