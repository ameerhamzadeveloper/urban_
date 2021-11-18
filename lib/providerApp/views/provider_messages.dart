// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/customerApp/views/more/chat_screen.dart';
import 'package:urban/services/sign_in_sign_up.dart';
class ProviderMessage extends StatefulWidget {
  @override
  _ProviderMessageState createState() => _ProviderMessageState();
}

class _ProviderMessageState extends State<ProviderMessage> {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<SignInSignUpProvider>(context);
    // final Stream<QuerySnapshot> documentStream = firestore.collection('recentChats').doc(pro.sHuserid.toString()).collection('myChats').snapshots();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.black,),
        ),
        title: Text("Messages"),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: StreamBuilder(
      //     stream: documentStream,
      //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
      //       if(snapshot.data == null){
      //         return Center(child: Text("No Messages"),);
      //       }else{
      //         return ListView(
      //           shrinkWrap: true,
      //           children: snapshot.data!.docs.map((DocumentSnapshot document) {
      //             Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      //             return Card(
      //               child: ListTile(
      //                 onTap: (){
      //                   Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(data['recieverName'],data['token'])));
      //                 },
      //                 title: Text(data['recieverName']),
      //                 subtitle: Text(data['lastMessage']),
      //                 trailing: Text(data['date']),
      //               ),
      //             );
      //           }).toList(),
      //         );
      //       }
      //     },
      //   )
      // ),
    );
  }
}
