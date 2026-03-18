import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class LocalNotificationService {
  LocalNotificationService._();

  static const _channelId = 'channelId';
  static const _channelName = 'Default Channel';
  static const _notificationId = 1;
  static const _notificationSound = 'mixkitlongpop2358';
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  static Future<void> init() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const settings = InitializationSettings(android: androidSettings);
    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: _onNotificationTap,
    );
  }

  @pragma('vm:entry-point')
  static void _onNotificationTap(NotificationResponse response) {
    log('Notification tapped with payload: ${response.payload}');
  }

  static Future<void> show(RemoteMessage message) async {
    final styleInformation = await _buildImageStyle(
      message.notification?.android?.imageUrl,
    );

    final androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      colorized: true,
      color: Colors.red,
      playSound: true,
      sound: const RawResourceAndroidNotificationSound(_notificationSound),
      styleInformation: styleInformation,
    );

    await _plugin.show(
      id: _notificationId,
      title: message.notification?.title,
      body: message.notification?.body,
      notificationDetails: NotificationDetails(android: androidDetails),
      payload: message.data.isNotEmpty ? jsonEncode(message.data) : null,
    );
  }

  static Future<StyleInformation?> _buildImageStyle(String? imageUrl) async {
    if (imageUrl == null || imageUrl.isEmpty) return null;

    try {
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode != 200) {
        log('Failed to fetch notification image: ${response.statusCode}');
        return null;
      }

      return BigPictureStyleInformation(
        ByteArrayAndroidBitmap.fromBase64String(
          base64Encode(response.bodyBytes),
        ),
      );
    } catch (e) {
      log('Error fetching notification image: $e');
      return null;
    }
  }
}
