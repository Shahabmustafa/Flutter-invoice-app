//
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationService{
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   Future<void> initNotification()async{
//     AndroidInitializationSettings initializationAndroid = AndroidInitializationSettings("invoice");
//     DarwinInitializationSettings initializationIOS = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       onDidReceiveLocalNotification: (id,title,body,payload){}
//     );
//
//     InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationAndroid,
//       iOS: initializationIOS,
//     );
//
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (details){},
//     );
//   }
//
//   Future<void> simpleNotificationShow(String body)async{
//     AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
//       "channelId",
//       "channelName",
//       priority: Priority.high,
//       importance: Importance.max,
//       icon: "invoice",
//       channelShowBadge: true,
//       largeIcon: DrawableResourceAndroidBitmap("invoice"),
//     );
//
//     NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
//
//     await flutterLocalNotificationsPlugin.show(
//         0,
//         "Invoice Message",
//         body,
//         notificationDetails,
//     );
//   }
// }
