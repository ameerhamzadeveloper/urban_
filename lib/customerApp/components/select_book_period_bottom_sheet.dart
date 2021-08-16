import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/constants.dart';
import 'package:urban/customerApp/services/home_page_services.dart';
import 'package:urban/customerApp/views/provider_details.dart';
class SelectPeriodBottomSheet extends StatefulWidget {
  final String? serviceName;
  SelectPeriodBottomSheet(this.serviceName);
  @override
  _SelectPeriodBottomSheetState createState() => _SelectPeriodBottomSheetState();
}
enum DurationVal { first, second, third }
class _SelectPeriodBottomSheetState extends State<SelectPeriodBottomSheet> {

  DurationVal? _duration = DurationVal.first;

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<HomePageServices>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15)
        ),
      ),

      child: Column(
        children: [
          Container(
            color: Colors.white,
            height: 100,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.serviceName ?? ""),
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.clear))
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     InkWell(
                //       onTap:(){},
                //       child: Card(
                //         clipBehavior: Clip.antiAlias,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(100)
                //         ),
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Icon(CupertinoIcons.minus),
                //         ),
                //       ),
                //     ),
                //     Text("1 PERSON"),
                //     InkWell(
                //       onTap:(){},
                //       child: Card(
                //         color: Colors.yellowAccent,
                //         clipBehavior: Clip.antiAlias,
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(100)
                //         ),
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Icon(CupertinoIcons.add),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  title: Text("DURATION"),
                ),
                Divider(),
                ListTile(
                  title: Text("30 MINUTES"),
                  trailing: Radio<DurationVal>(
                    // fillColor: Color(0xff17B5AF),
                    activeColor: Color(0xff17B5AF),
                    onChanged: (val){
                      pro.preiod = '30';
                      setState(() {
                        _duration = val;
                      });
                      pro.calculateEndTime();
                      pro.printt();
                    },
                    value: DurationVal.first,
                    groupValue: _duration,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text("60 MINUTES"),
                  trailing: Radio<DurationVal>(
                    activeColor: Color(0xff17B5AF),
                    onChanged: (val){
                      pro.preiod = '60';
                      setState(() {
                        _duration = val;
                      });
                      pro.calculateEndTime();
                      pro.printt();
                    },
                    value: DurationVal.second,
                    groupValue: _duration,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text("2 HOURS"),
                  trailing: Radio<DurationVal>(
                    activeColor: Color(0xff17B5AF),
                    onChanged: (val){
                      pro.preiod = '120';
                      setState(() {
                        _duration = val;
                      });
                      pro.calculateEndTime();
                      pro.printt();
                    },
                    value: DurationVal.third,
                    groupValue: _duration,
                  ),
                ),
                Divider(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: MaterialButton(
              minWidth: double.infinity,
              shape: StadiumBorder(),
              child: Text("Book session now"),
              onPressed: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ProviderDetails()
                ));
              },
              color: kButtonColor,
            ),
          )
        ],
      ),
    );
  }
}
