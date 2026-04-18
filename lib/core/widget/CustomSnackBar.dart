import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Customsnackbar {
  static void show({
    required BuildContext context,
    required Color backgroundColor,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        dismissDirection: DismissDirection.endToStart,
        content: Text(
          message,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w700,
            color: context.palette.white,
            fontSize: ScreenUtilsManager.h16,
          ),
        ),
      ),
    );
  }
}
