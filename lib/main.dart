import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;

void main() => runApp(const NotificationsGen());

class NotificationsGen extends StatefulWidget {
  const NotificationsGen({Key? key}) : super(key: key);

  @override
  _NotificationsGenState createState() => _NotificationsGenState();
}

class _NotificationsGenState extends State<NotificationsGen> {
  late FlutterLocalNotificationsPlugin flutterLocalNotification;
  @override
  void initState() {
    super.initState();
    var androidInit = const AndroidInitializationSettings('ic_launcher');
    var iOSInit = const IOSInitializationSettings();
    var initilizationSettings =
        InitializationSettings(android: androidInit, iOS: iOSInit);
    flutterLocalNotification = FlutterLocalNotificationsPlugin();
    flutterLocalNotification.initialize(initilizationSettings,
        onSelectNotification: onNotificationSelected);
  }

  Future onNotificationSelected(String? payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification : $payload"),
      ),
    );
  }

  Future _showNotification() async {
    const String groupKey = 'Grouped notification';
    const String groupChannelId = 'Channel 1';
    const String groupChannelName = 'Group 1';
    const String groupChannelDescription = 'Test notitication channel group';
    const String threadId = 'thread1';

    const AndroidNotificationDetails firstNotificationAndroidSpecifics =
        AndroidNotificationDetails(
            groupChannelId, groupChannelName, groupChannelDescription,
            importance: Importance.max,
            priority: Priority.high,
            groupKey: groupKey);
    const NotificationDetails firstNotificationPlatformSpecifics =
        NotificationDetails(android: firstNotificationAndroidSpecifics);
    await flutterLocalNotification.show(1, 'Alex Faarborg',
        'You will not believe...', firstNotificationPlatformSpecifics);
    const AndroidNotificationDetails secondNotificationAndroidSpecifics =
        AndroidNotificationDetails(
            groupChannelId, groupChannelName, groupChannelDescription,
            importance: Importance.max,
            priority: Priority.high,
            groupKey: groupKey);
    const IOSNotificationDetails iOSSecondPlatformChannelSpecifics =
        IOSNotificationDetails(threadIdentifier: threadId);
    const NotificationDetails secondNotificationPlatformSpecifics =
        NotificationDetails(
            android: secondNotificationAndroidSpecifics,
            iOS: iOSSecondPlatformChannelSpecifics);
    await flutterLocalNotification.show(
        2,
        'Jeff Chang',
        'Please join us to celebrate the...',
        secondNotificationPlatformSpecifics);

// Create the summary notification to support older devices that pre-date
    /// Android 7.0 (API level 24).
    ///
    /// Recommended to create this regardless as the behaviour may vary as
    /// mentioned in https://developer.android.com/training/notify-user/group
    const List<String> lines = <String>[
      'Alex Faarborg  Check this out',
      'Jeff Chang    Launch Party'
    ];
    const InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
        lines,
        contentTitle: '2 messages',
        summaryText: 'example@example.com');
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            groupChannelId, groupChannelName, groupChannelDescription,
            styleInformation: inboxStyleInformation,
            groupKey: groupKey,
            setAsGroupSummary: true);
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(threadIdentifier: threadId);
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotification.show(
        3, 'Attention', 'Two messages', platformChannelSpecifics);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Notifications Example",
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Flutter Notification Example"),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _showNotification,
                  child: const Text('Show notification'),
                ),
              ],
            ),
          ),
        ));
  }
}
