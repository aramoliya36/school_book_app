import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:skoolmonk/common/shared_preference.dart';

class AppNotificationHandler {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  static AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  ///get fcm token
  static Future<String> getFcmToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    try {
      String token = await firebaseMessaging.getToken();

      await PreferenceManager.setFcmToken(token);
      log("=========fcm-token===$token");
      return token;
    } catch (e) {
      log("=========fcm- Error :$e");
      return null;
    }
  }

  ///call when app in fore ground
  static void showMsgHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      print(
          'NOtification Call :${notification?.apple}${notification.body}${notification.title}');
      if (message != null) {
        print(
            "action==onMessage.listen====1=== ${message?.data['action_click']}");
        print("slug======2=== ${message?.data['slug_name']}");
        showMsg(notification);
      }
    });
  }

  /// handle notification when app in fore ground..///close app
  static void getInitialMsg() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      print('------RemoteMessage message------$message');
      if (message != null) {
        print("action======1=== ${message?.data['action_click']}");
        print("slug======2=== ${message?.data['slug_name']}");
        // _singleListingMainTrailController.setSlugName(
        //     slugName: '${message?.data['slug_name']}');
      }
    });
  }

  ///show notification msg
  static void showMsg(RemoteNotification notification) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel', // id
            'High Importance Notifications', // title
            'This channel is used for important notifications.',
            // description
            importance: Importance.high,
            icon: '@drawable/ic_stat_name',
          ),
        ));
  }

  ///background notification handler..
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
    RemoteNotification notification = message.notification;
  }

  ///call when click on notification back
  static void onMsgOpen() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print('listen->${message.data}');
      if (message != null) {
        // print("action======1=== ${message?.data['action_click']}");
        print("action======2=== ${message?.data['action_click']}");

        // _barViewModel.selectedRoute('DashBoardScreen');
        // _barViewModel.selectedBottomIndex(0);

        // Get.offAll(SplashPage());
      }
    });
  }
}
