import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:urban/constants.dart';
import 'package:urban/providerApp/services/service.dart';

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UnderlineInputBorder borderColor  = UnderlineInputBorder(
  borderSide: BorderSide(color: kProfileCircleBorderColor),
  );
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<Services>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Add Service"),
      ),
      body: Container(
        color: pro.isServiceAdd ? Colors.grey[100] : Colors.white,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                ListView(
                  children: [
                    Card(
                      child: TextFormField(
                        cursorColor: kProfileCircleBorderColor,
                          onChanged: (val) {
                            pro.serviceName = val;
                          },
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return "Please Provide Name";
                            }
                          },
                          decoration:
                              InputDecoration(
                                focusedBorder: borderColor,
                                  hintText: "Service Name",)),
                    ),
                    DropdownButton(
                      itemHeight: 80.0,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down),
                      value: pro.selectedService,
                      onChanged: (newValue) {
                        pro.changeService(newValue.toString());
                      },
                      items: pro.servicesList.map((location) {
                        return DropdownMenuItem(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList(),
                    ),
                    // DropdownButton(
                    //   itemHeight: 80.0,
                    //   isExpanded: true,
                    //   icon: Icon(Icons.arrow_drop_down),
                    //   value: pro.selectedSubServices,
                    //   onChanged: (newValue) {
                    //     pro.changeSubService(newValue.toString());
                    //   },
                    //   items: pro.subServicesList.map((location) {
                    //     return DropdownMenuItem(
                    //       child: new Text(location),
                    //       value: location,
                    //     );
                    //   }).toList(),
                    // ),
                    Card(
                      child: TextFormField(
                        cursorColor: kProfileCircleBorderColor,
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          pro.servicePrice = val;
                        },
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "Please Provide Price";
                          }
                        },
                        decoration: InputDecoration(
                          focusedBorder: borderColor,
                          hintText: "Service Price",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            pro.selectStartTime(context);
                          },
                          child: Column(
                            children: [
                              Text("Start Time"),
                              SizedBox(
                                height: 10,
                              ),
                              pro.isStartTimeSelected
                                  ? Text(
                                      "${pro.selectedStartTime.format(context)}",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Image.asset(
                                      "images/date.png",
                                      height: 150,
                                      fit: BoxFit.fill,
                                    ),
                            ],
                          ),
                        ),
                        Text("To"),
                        InkWell(
                          onTap: () {
                            pro.selectEndTime(context);
                          },
                          child: Column(
                            children: [
                              Text("End Time"),
                              SizedBox(
                                height: 10,
                              ),
                              pro.isEndTimeSelected
                                  ? Text(
                                      "${pro.selectedEndTime.format(context)}",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Image.asset(
                                      "images/date.png",
                                      height: 150,
                                      fit: BoxFit.fill,
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: TextFormField(
                        cursorColor: kProfileCircleBorderColor,
                        maxLines: 4,
                        onChanged: (val) {
                          pro.description = val;
                        },
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "Please Provide Description";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Description",
                          focusedBorder: borderColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Service Availibility"),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 5.0,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: MaterialButton(
                                      shape: StadiumBorder(
                                          side: BorderSide(color: Colors.grey)),
                                      color: pro.monday
                                          ? kButtonColor
                                          : Colors.white,
                                      onPressed: () {
                                        pro.slectDay("monday");
                                      },
                                      child: Text("Monday"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: MaterialButton(
                                      shape: StadiumBorder(
                                          side: BorderSide(color: Colors.grey)),
                                      color: pro.tuesday
                                          ? kButtonColor
                                          : Colors.white,
                                      onPressed: () {
                                        pro.slectDay("teusday");
                                      },
                                      child: Text("Tuesday"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: MaterialButton(
                                      shape: StadiumBorder(
                                          side: BorderSide(color: Colors.grey)),
                                      color: pro.wednesday
                                          ? kButtonColor
                                          : Colors.white,
                                      onPressed: () {
                                        pro.slectDay("wednesday");
                                      },
                                      child: Text("Wednesday"),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: MaterialButton(
                                      shape: StadiumBorder(
                                          side: BorderSide(color: Colors.grey)),
                                      color: pro.thursday
                                          ? kButtonColor
                                          : Colors.white,
                                      onPressed: () {
                                        pro.slectDay("thursday");
                                      },
                                      child: Text("Thursday"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: MaterialButton(
                                      shape: StadiumBorder(
                                          side: BorderSide(color: Colors.grey)),
                                      color: pro.friday
                                          ? kButtonColor
                                          : Colors.white,
                                      onPressed: () {
                                        pro.slectDay("friday");
                                      },
                                      child: Text("Friday"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: MaterialButton(
                                      shape: StadiumBorder(
                                          side: BorderSide(color: Colors.grey)),
                                      color: pro.saturday
                                          ? kButtonColor
                                          : Colors.white,
                                      onPressed: () {
                                        pro.slectDay("saturday");
                                      },
                                      child: Text("Saturday"),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: MaterialButton(
                                      shape: StadiumBorder(
                                          side: BorderSide(color: Colors.grey)),
                                      color: pro.sunday
                                          ? kButtonColor
                                          : Colors.white,
                                      onPressed: () {
                                        pro.slectDay("sunday");
                                      },
                                      child: Text("Sunday"),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    pro.showSelfieImage(),
                    pro.isPicSelected
                        ? Text(
                            "Please Provide at least 1 image",
                            style: TextStyle(color: Colors.red),
                          )
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    // Text("Pick Your Location"),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     print("picked");
                    //     const LatLng position = LatLng(26.431228, 67.611032);
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => PlacePicker(
                    //           apiKey: PLACES_API_KEY, // Put YOUR OWN KEY here.
                    //           onPlacePicked: (result) {
                    //             print(result.formattedAddress);
                    //             Navigator.of(context).pop();
                    //           },
                    //           initialPosition: position,
                    //           useCurrentLocation: true,
                    //           hintText: "Select Location",
                    //           selectInitialPosition: true,
                    //           selectedPlaceWidgetBuilder: (_, selectedPlace,
                    //               state, isSearchBarFocused) {
                    //             print(
                    //                 "state: $state, isSearchBarFocused: $isSearchBarFocused");
                    //             return isSearchBarFocused
                    //                 ? Container()
                    //                 : FloatingCard(
                    //                     bottomPosition:
                    //                         0.7, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                    //                     leftPosition: 0.0,
                    //                     rightPosition: 0.0,
                    //                     width: 500,
                    //                     borderRadius:
                    //                         BorderRadius.circular(12.0),
                    //                     child: state == SearchingState.Searching
                    //                         ? Center(
                    //                             child:
                    //                                 CircularProgressIndicator())
                    //                         : TextButton(
                    //                             child: Text("Pick Here"),
                    //                             onPressed: () {
                    //                               // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                    //                               //            this will override default 'Select here' Button.
                    //                               print(
                    //                                   "do something with [selectedPlace] data");
                    //                               Navigator.of(context).pop();
                    //                             },
                    //                           ),
                    //                   );
                    //           },
                    //         ),
                    //       ),
                    //     );
                    //     print("Picked End");
                    //   },
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Icon(Icons.location_on),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       Text("Pick Location")
                    //     ],
                    //   ),
                    // ),
                    Row(
                      children: [
                        Checkbox(
                          value: pro.isPublish,
                          onChanged: (val) {
                            pro.isPublishService();
                          },
                        ),
                        Text("I want to Publish this Service now")
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      shape: StadiumBorder(),
                      color: Colors.yellow,
                      onPressed: () {
                        pro.submitServiceCalled();
                        pro.publishService(context);
                        // Navigator.pop(context);
                      },
                      child: Text("Add Service"),
                    )
                  ],
                ),
                pro.isServiceAdd
                    ? Align(
                        alignment: Alignment.center,
                        child: SpinKitSquareCircle(
                          color: Colors.purpleAccent,
                          size: 50.0,
                        ))
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
