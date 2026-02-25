import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';

class Customsnackbar {
  static show({
    required context,
    required Color backgroundColor,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.all(16),
        duration: Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        dismissDirection: DismissDirection.endToStart,
        content: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: ColorManger.white,
            fontSize: ScreenUtilsManager.h16,
          ),
        ),
      ),
    );
  }
}
