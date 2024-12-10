import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notification_app/notification.dart';

import 'notification_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:math';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotificationDemo(),
    );
  }
}

class NotificationDemo extends StatefulWidget {
  @override
  _NotificationDemoState createState() => _NotificationDemoState();
}

class _NotificationDemoState extends State<NotificationDemo> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _startNotificationTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  int generateRandomNumber() {
    Random random = Random();
    return 1000 + random.nextInt(9000);
  }

  Future<void> _sendNotification(int code) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      code, // Unique notification ID
      'Password Reset OTP',
      '$code is your Aksion app password reset OTP.',
      platformChannelSpecifics,
    );
  }

  void _startNotificationTimer() {
    timer = Timer.periodic(Duration(seconds: 10), (timer) {
      int otp = generateRandomNumber();
      _sendNotification(otp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Periodic Notifications Demo'),
      ),
      body: Center(
        child: Text(
          'Notifications sent every 10 seconds.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
