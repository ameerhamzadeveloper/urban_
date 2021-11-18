import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'package:urban/constants.dart';
import 'package:urban/customerApp/components/select_book_period_bottom_sheet.dart';
import 'package:urban/customerApp/services/home_page_services.dart';

class ProvidersScreen extends StatefulWidget {
  @override
  _ProvidersScreenState createState() => _ProvidersScreenState();
}

class _ProvidersScreenState extends State<ProvidersScreen> {
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<HomePageServices>(context);
    var nextMonth = pro.dateTime.month + 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.black,),
        ),
        title: Text(pro.nearProviders!.length == 0 ? "Pick a date & time that suits you" : "Choose your practitioner"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 130,
              color: page1Color,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat.MMMM().format(pro.dateTime).toString(),
                        style: TextStyle(fontSize: 22,color: Colors.white),
                      ),
                      SizedBox(width: 5,),
                      Text(pro.dateTime.year.toString(),style: TextStyle(fontSize: 22,color: Colors.white))
                    ],
                  ),
                  SizedBox(height: 20),
                  FlutterDatePickerTimeline(
                    itemHeight: 50,
                    selectedItemBackgroundColor: kButtonColor,
                    selectedItemTextStyle: TextStyle(color: Colors.black),
                    unselectedItemTextStyle: TextStyle(color: Colors.black),
                    unselectedItemWidth: 50,
                    startDate: DateTime(pro.dateTime.year, pro.dateTime.month, pro.dateTime.day),
                    endDate: DateTime(pro.dateTime.year, nextMonth, pro.dateTime.day),
                    initialSelectedDate: DateTime(pro.dateTime.year, pro.dateTime.month, pro.dateTime.day),
                    onSelectedDateChange: (DateTime? dateTime) {
                      // print(dateTime);
                      var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
                      var inputDate = inputFormat.parse(dateTime.toString());
                      var outputFormat = DateFormat('yyyy/MM/dd');
                      var en =  outputFormat.format(inputDate);
                      print(en);
                      pro.selectedDate = en;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: pro.serviceTime.length,
                itemBuilder: (ctx,i){
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: MaterialButton(
                        color: pro.serviceTime[i].isSelected ? page1Color : page2Color,
                        onPressed: (){
                          pro.clearProvidersList();
                          pro.makeTimeSelec(i);
                          pro.timeSelected();
                          pro.selectedTime = pro.serviceTime[i].time;
                          pro.fetchNearProviders('1');
                        },
                        child: pro.serviceTime[i].isSelected ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(pro.serviceTime[i].time,style: TextStyle(color: pro.serviceTime[i].isSelected ? Colors.white : Colors.black),),
                            SizedBox(height: 5,),
                            CircleAvatar(
                              radius: 10,
                                backgroundColor:Colors.white,
                                child: Icon(Icons.check,color: Color(0xff00032D),size: 15,))
                          ],
                        ) : Text(pro.serviceTime[i].time,style: TextStyle(color: pro.serviceTime[i].isSelected ? Colors.white : Colors.black),),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10,),
            pro.isTimeSelected ? Container(): SpeechBubble(
              color: page1Color,
              nipLocation: NipLocation.TOP,
              child: Text("Select a time to see who is available",style: TextStyle(color: Colors.white),),
            ),
            pro.isSearching ? CupertinoActivityIndicator(
              radius: 20,
              animating: true,
            ):Container(),
            GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                shrinkWrap: true,
                children: List.generate(pro.nearProviders == null ? 0 : pro.nearProviders!.length, (i) {
                  return Container(
                    // height: 250,
                    child: InkWell(
                      onTap: ()async{
                        await pro.fetchProviderAndServiceDetails(pro.nearProviders?[i].serviceId.toString());
                        pro.calculateEndTime();
                        pro.printt();
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15)
                              ),
                            ),
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => Container(
                                height: MediaQuery.of(context).size.height - 100,
                                color: Colors.transparent,
                              // padding: EdgeInsets.only(
                              //     bottom: MediaQuery.of(context)
                              //         .viewInsets
                              //         .bottom),
                              child: SelectPeriodBottomSheet(pro.nearProviders?[i].serviceName.toString()),
                            ));
                        print(pro.nearProviders?[i].serviceId);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  // height: 80,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(pro.nearProviders?[i].serviceImage ?? "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg")
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30)
                                    )
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(pro.nearProviders?[i].serviceName ?? "",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("£"),
                                  Text(pro.nearProviders?[i].servicePrice ?? "")
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Rating"),
                                  SizedBox(width: 5,),
                                  Text("${pro.nearProviders?[i].distance ?? ""}")
                                ],
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }))
          ],
        ),
      ),
    );
  }
}
