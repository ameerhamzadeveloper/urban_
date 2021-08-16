import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:urban/routes/routes_names.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();
  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),iOS: IOSInitializationSettings());

    _notificationsPlugin.initialize(initializationSettings,onSelectNotification: (String? route) async{
      if(route != null){
        print("data $route");
        if(route == 'audio'){
          Navigator.of(context).pushNamed(audioIncomming);
        }
      }
    });
  }

  static void display(RemoteMessage message) async {

    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/1000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "metis",
            "metis channel",
            "this is our channel",
            importance: Importance.max,
            priority: Priority.high,
            channelShowBadge: true,
            enableVibration: true,
            fullScreenIntent: true,
            ongoing: true,
            autoCancel: false,
            playSound: true,
            timeoutAfter: 10000,
            visibility: NotificationVisibility.public,
          ),
        iOS: IOSNotificationDetails(
          presentSound: true,
          presentAlert: true,
        )
      );
      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data["call"],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}