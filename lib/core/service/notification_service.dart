import 'dart:developer';
import 'package:citifix/core/service/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  NotificationService._();

  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    await _requestPermission();
    await _logToken();
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
    _listenToForegroundMessages();
    _listenToNotificationClick();
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
      log('Foreground message: ${message.data}');
      LocalNotificationService.show(message);
    });
  }

  @pragma('vm:entry-point')
  static Future<void> _onBackgroundMessage(RemoteMessage message) async {
    WidgetsFlutterBinding.ensureInitialized();
    await LocalNotificationService.init();
    log('Background message: ${message.data}');
    await LocalNotificationService.show(message);
  }
  static void _listenToNotificationClick() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log('Notification clicked: ${message.data}');
    });
  }
}
