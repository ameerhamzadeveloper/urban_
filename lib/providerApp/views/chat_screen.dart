// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/services/sign_in_sign_up.dart';
class ProviderChatScreen extends StatefulWidget {
  final String recieverName;
  final String fcmToken;
  ProviderChatScreen(this.recieverName,this.fcmToken);
  @override
  _ProviderChatScreenState createState() => _ProviderChatScreenState();
}
class _ProviderChatScreenState extends State<ProviderChatScreen> {
  DateTime date = DateTime.now();
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<SignInSignUpProvider>(context);
    // final Stream<QuerySnapshot> documentStream = firestore.collection('chats').doc(pro.sHuserid.toString()).collection('recieverID').orderBy('timestamp').snapshots();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.recieverName.toString()),
        actions: [
          IconButton(
            onPressed: () {
              pro.joinAudioMeeting();
            },
            icon: Icon(Icons.call, color: Colors.black,),
          ),
          IconButton(
            onPressed: () {
              pro.joinVideoMeeting();
            },
            icon: Icon(Icons.videocam_outlined, color: Colors.black,),
          )
        ],
      ),
      // body: Column(
      //   // mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Expanded(
      //       child: StreamBuilder(
      //         stream: documentStream,
      //         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
      //           if(snapshot.data == null){
      //             return Container();
      //           }else{
      //             return ListView(
      //               // physics: NeverScrollableScrollPhysics(),
      //               shrinkWrap: true,
      //               children: snapshot.data!.docs.map((DocumentSnapshot document) {
      //                 Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      //                 return Padding(
      //                   padding: EdgeInsets.all(10.0),
      //                   child: Column(
      //                     crossAxisAlignment:
      //                     data['senderID'] == pro.sHuserid ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      //                     children: <Widget>[
      //                       Material(
      //                         borderRadius: data['senderID'] == pro.sHuserid
      //                             ? BorderRadius.only(
      //                             topLeft: Radius.circular(30.0),
      //                             bottomLeft: Radius.circular(30.0),
      //                             bottomRight: Radius.circular(30.0))
      //                             : BorderRadius.only(
      //                           bottomLeft: Radius.circular(30.0),
      //                           bottomRight: Radius.circular(30.0),
      //                           topRight: Radius.circular(30.0),
      //                         ),
      //                         elevation: 5.0,
      //                         color: data['senderID'] == pro.sHuserid ? Colors.lightBlueAccent : Colors.grey,
      //                         child: Padding(
      //                           padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      //                           child: Text(
      //                             data['message'],
      //                             style: TextStyle(
      //                               color: data['senderID'] == pro.sHuserid ? Colors.white : Colors.black54,
      //                               fontSize: 15.0,
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 );
      //               }).toList(),
      //             );
      //           }
      //         },
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 8.0,bottom: 10),
      //       child: Column(
      //         children: [
      //           Container(
      //             height: 2,
      //             color: Colors.grey,
      //           ),
      //           Row(
      //             children: [
      //               Expanded(child: TextField(
      //                 controller: message,
      //                 decoration: InputDecoration(
      //                     border: InputBorder.none,
      //                     hintText: "Type Your Message"
      //                 ),
      //               ),
      //               ),
      //               IconButton(onPressed: () {
      //                 firestore.collection('chats').doc(pro.sHuserid.toString()).collection('recieverID').add({
      //                   'message':message.text,
      //                   'date': "${date.year}/${date.month}/${date.day}",
      //                   'timestamp':DateTime.now(),
      //                   'recieverID':'id',
      //                   'senderID':pro.sHuserid,
      //                 });
      //                 firestore.collection('chats').doc('recieverID').collection(pro.sHuserid.toString()).add({
      //                   'message':message.text,
      //                   'date': "${date.year}/${date.month}/${date.day}",
      //                   'timestamp':DateTime.now(),
      //                   'recieverID':pro.sHuserid,
      //                   'senderID':'id',
      //                 });
      //                 firestore.collection('recentChats').doc('recieverID').collection('myChats').doc(pro.sHuserid).set({
      //                   'lastMessage':message.text,
      //                   'date': "${date.year}/${date.month}/${date.day}",
      //                   'timestamp':DateTime.now(),
      //                   'recieverID':pro.sHuserid,
      //                   'senderID':'id',
      //                   'recieverName':"${pro.sHuserFirst}${pro.sHuserLast}",
      //                   'token': widget.fcmToken,
      //                 });
      //                 firestore.collection('recentChats').doc(pro.sHuserid.toString()).collection('myChats').doc('recieverID').set({
      //                   'lastMessage':message.text,
      //                   'date': "${date.year}/${date.month}/${date.day}",
      //                   'timestamp':DateTime.now(),
      //                   'recieverID':'id',
      //                   'senderID':pro.sHuserid,
      //                   'recieverName':widget.recieverName,
      //                   'token':widget.fcmToken,
      //                 });
      //                 message.clear();
      //               }, icon: Icon(Icons.send))
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
