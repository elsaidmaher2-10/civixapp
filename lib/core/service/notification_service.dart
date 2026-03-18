import 'dart:developer';
import 'package:citifix/core/service/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  NotificationService._();

  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    await _requestPermission();
    await _logToken();
    await _messaging.subscribeToTopic('All');

    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
    _listenToForegroundMessages();
  }

  static Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission();
    log('Notification permission: ${settings.authorizationStatus}');
  }

  static Future<void> _logToken() async {
    final token = await _messaging.getToken();
    log('FCM Token: ${token ?? 'unavailable'}');
  }

  static void _listenToForegroundMessages() {
    FirebaseMessaging.onMessage.listen((message) {
      log('Foreground message: ${message.notification?.title}');
      LocalNotificationService.show(message);
    });
  }

  @pragma('vm:entry-point')
  static Future<void> _onBackgroundMessage(RemoteMessage message) async {
    log('Background message: ${message.notification?.title}');
    await LocalNotificationService.show(message);
  }
}