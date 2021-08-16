import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/constants.dart';
import 'package:urban/customerApp/services/home_page_services.dart';
import 'package:urban/customerApp/views/more/emergency_resources.dart';
class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<HomePageServices>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Support"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Do you have a question, concern, idea, feedback, or problem?",style: TextStyle(fontSize: 22),),
              SizedBox(height: 5,),
              Text("Metis is here for you when you need non-urgent information about mental health support."),
              SizedBox(height: 10,),
              Text("Take a look at our frequently asked questions for some quick answers. If you still need assistance, please fill out the form below and we'd be happy to help!"),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      DropdownButton(
                        itemHeight: 80.0,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        value: pro.selectedQuestions,
                        onChanged: (newValue) {
                          pro.changeQuestions(newValue.toString());
                        },
                        items: pro.questions.map((location) {
                          return DropdownMenuItem(
                            child: new Text(location),
                            value: location,
                          );
                        }).toList(),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: "First Name"
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextField(
                        decoration: InputDecoration(
                            hintText: "Last Name"
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextField(
                        decoration: InputDecoration(
                            hintText: "Email"
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextField(
                        maxLines: 3,
                        decoration: InputDecoration(
                            hintText: "Message"
                        ),
                      ),
                      SizedBox(height: 30,),
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        color: kButtonColor,
                        shape: StadiumBorder(),
                        onPressed: (){},
                        child: Text("Submit"),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text("If you are in a crisis or any other person may be in danger - don't use this site."),
              InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmergencyResources()));
                },
                  child: Text(" These resources can provide you with immediate help",style: TextStyle(color: Colors.blue),))
            ],
          ),
        ),
      ),
    );
  }
}
