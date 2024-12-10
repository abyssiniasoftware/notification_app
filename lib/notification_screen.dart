import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = '/notification-screen';

  @override
  Widget build(BuildContext context) {
    final String notificationPayload =
        ModalRoute.of(context)?.settings.arguments as String? ?? "No Data";

    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Details'),
      ),
      body: Center(
        child: Text(
          'Notification: $notificationPayload',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
