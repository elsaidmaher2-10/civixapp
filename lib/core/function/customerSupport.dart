import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter/material.dart';

class Customersupport {
  static Future<void> sendEmail(String body) async {
    final Email email = Email(
      subject: "Support Request - Citifix App",
      recipients: ["elsaidmaher@students.du.edu.eg"],
      body: body,
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      // لو حصل مشكلة (مثلاً مفيش تطبيق Gmail)
      debugPrint("Email Error: ${error.toString()}");
    }
  }
}
