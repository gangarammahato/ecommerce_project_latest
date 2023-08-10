import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final LocalNotificationService _instance =
      LocalNotificationService._();
  LocalNotificationService._();

  factory LocalNotificationService() {
    return _instance;
  }
  final FlutterLocalNotificationsPlugin _flutterLocalNotification =
      FlutterLocalNotificationsPlugin();
  initialize() {
    _requestPermission();
    _handlerForForeGroundNotification();
  }

  _handlerForForeGroundNotification() {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const initializationSetting = InitializationSettings(
      android: AndroidInitializationSettings('ic_launcher'),
    );

    _flutterLocalNotification.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (details) {},
      // onDidReceiveBackgroundNotificationResponse: (details) {
      // app background vako notification ma click garda app ko kun page kholne code yo ma lekhne

      // },
    );
  }

  _requestPermission() async {
    _flutterLocalNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  generatedNotification({
    required String title,
    required String description,
    String? payLoad,
  }) {
    _flutterLocalNotification.show(
      Random().nextInt(1000),
      title,
      description,
      NotificationDetails(
        android: AndroidNotificationDetails(
          "ecommerce_app",
          "basic",
        ),
      
      ),
      payload: payLoad,
    );
  }
}
