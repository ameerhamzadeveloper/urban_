import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Ameer"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.call, color: Colors.black,),
          ),
          IconButton(
            onPressed: () {
              _joinMeeting();
            },
            icon: Icon(Icons.videocam_outlined, color: Colors.black,),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: [

                Container(
                  height: 2,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Expanded(child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type Your Message"
                        ),
                      )),
                      IconButton(onPressed: () {

                      }, icon: Icon(Icons.send))
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void _joinMeeting() async {
  try {
    FeatureFlag featureFlag = FeatureFlag();
    featureFlag.welcomePageEnabled = false;
    featureFlag.addPeopleEnabled = false;
    featureFlag.inviteEnabled = false;
    featureFlag.videoShareButtonEnabled = false;
    featureFlag.resolution = FeatureFlagVideoResolution.HD_RESOLUTION; // Limit video resolution to 1280p
    var options = JitsiMeetingOptions(room : "myRoom123")

      ..subject = "Ameer"
      ..userDisplayName = "Ameer"
      ..userEmail = "myemail@email.com";

    await JitsiMeet.joinMeeting(
        options,
      listener: JitsiMeetingListener(
        onConferenceTerminated: (user){
          print(user);
          print("User Ended");
        }
      )
    );
  } catch (error) {
    debugPrint("error: $error");
  }
}