import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/progress_indicator.dart';
import 'package:urban/constants.dart';
import 'package:urban/providerApp/model/service_drop_down.dart';
import 'package:urban/providerApp/services/service.dart';
import 'package:urban/providerApp/views/services/add_service.dart';
class ServicesScreen extends StatefulWidget {
  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<Services>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Services"),
        leading: IconButton(
          onPressed: (){
            pro.services.clear();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.black,),
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddService()));
            },
            icon:Icon(Icons.add_box_outlined,color: Colors.black,)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: pro.services.length != 0 ?  ListView.builder(
          itemCount: pro.services.length > 0 ?  pro.services.length : 0,
          itemBuilder: (ctx,i){
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.network("${pro.services[i].serviceImage}",height: 200,fit: BoxFit.cover,width: MediaQuery.of(context).size.width,),
                        Align(
                          alignment: Alignment.topRight,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              onChanged: (ServiceDropDown? name){
                                print(name!.namel);
                                print(pro.services[i].serviceStatus);
                                if(name.namel == "Pause Service"){
                                  pro.pauseOrActiveService(pro.services[i].serviceId.toString(), pro.services[i].serviceStatus == '1' ? "2" :'1');
                                }else{
                                  pro.deleteService(pro.services[i].serviceId.toString());
                                }
                              },
                              icon: Icon(Icons.more_vert,color: Colors.black,),
                              items: ServiceDropDown?.nameList().map((name) => DropdownMenuItem(
                                value: name,
                                child: Text(name.namel ?? ""),
                              )).toList(),
                            ),
                          )
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                color:pro.services[i].serviceStatus == '1' ? Colors.green : Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: Text(pro.services[i].serviceStatus == '1' ? "Active" : "Pause",style: TextStyle(color: Colors.white),),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text(pro.services[i].serviceName ?? "Loading...",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'Roboto'),),
                    SizedBox(height: 10,),
                    Text(pro.services[i].serviceDescription ?? "Loading..."),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Price"),
                        Text("\$${pro.services[i].servicePrice ?? '\$'}",style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Timing"),
                        Text("${pro.services[i].serviceStartTime ?? '0:00'} to ${pro.services[i].serviceEndTime ?? '0:00'}",style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                    SizedBox(height: 20,),
                    MaterialButton(
                      color: kButtonColor,
                      onPressed: (){},
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text("Edit"),Icon(Icons.edit),],),
                    )
                  ],
                ),
              ),
            );
          },
        ):Center(child: AppProgressIndicator())
      ),
    );
  }
}