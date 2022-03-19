import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {

  //Singleton pattern
  static final NotificationService _notificationService =
  NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  Future<void> init() async {

    tz.initializeTimeZones();
    //Initialization Settings for Android
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('ic_notify');

    //Initialization Settings for iOS
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    //InitializationSettings for initializing settings for both platforms (Android & iOS)
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

    Future<void> showNotifications(String body, DateTime time) async {
      await flutterLocalNotificationsPlugin.zonedSchedule(
          0,
          'Your todo is due in 10 minutes',
          body,
          tz.TZDateTime.from(time, tz.local),
          const NotificationDetails(
            android: AndroidNotificationDetails(
                'main_channel',
                'Main Channel',
                playSound: true,
                priority: Priority.high,
                importance: Importance.high,
              icon: 'ic_notify',
            ),
            iOS: IOSNotificationDetails(
              presentSound: true,
              presentBadge: true,
              presentAlert: true,
            ),
          ),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

