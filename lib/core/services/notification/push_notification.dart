import 'dart:convert' show json;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:task/features/home/profile/profile/profile_controller.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../utils/functions/functions.dart';

class PushNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> listenNotifications() async {
    await _initLocalNotifications();
    await _requestPermissions();
  }

  static Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onSelectNotification,
      onDidReceiveBackgroundNotificationResponse: _onSelectNotification,
    );
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>();
      await androidImplementation?.requestPermission();
    }
  }

    final ProfileController profileController = Get.put(ProfileController());
  Future<void> showNotification(String title, String body) async {
if(profileController.receiveNotifications.value == true){
  
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
        

    await _flutterLocalNotificationsPlugin.show(
        getRandomInt(3), title, body, notificationDetails,
        payload: 'item x');
        
}
  }

Future<void> zonedScheduleNotification(BuildContext context) async {
  if(profileController.receiveNotifications.value == true){
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("You will receive notification in 5 seconds ⏰"),
    ));
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Congratulations! 🎉',
        'You recived the scheduled notification',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);}
  }

  //**************************************************
  // Handle tap on local notification tray
  static void _onSelectNotification(NotificationResponse res) {
    List<String> data = [];
    data = res.payload!.split('+');
    Map<String, dynamic> object = json.decode(data[3]);
    if (data.isNotEmpty) {
      _onNotification(data[0], data[1], data[2], object);
    }
  }

  static Future<void> _onNotification(
    String senderId,
    String type,
    String topic,
    Map<String, dynamic> object,
  ) async {}
  
}
