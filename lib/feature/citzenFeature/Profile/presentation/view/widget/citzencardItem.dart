import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildItem(BuildContext context, String title, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.cairo(
          fontSize: ScreenUtilsManager.s12,
          fontWeight: FontWeight.bold,
          color: context.palette.kPrimary,
        ),
      ),
      Text(
        value,
        style: GoogleFonts.cairo(
          fontSize: ScreenUtilsManager.s14,
          fontWeight: FontWeight.w600,
          color: context.palette.onSurface,
        ),
      ),
    ],
  );
}
