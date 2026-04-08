import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget homeAppbar(context) {
  return AppBar(
    backgroundColor: ColorManger.surfaceContainerLowest,
    elevation: 0,
    automaticallyImplyLeading: false,
    scrolledUnderElevation: 0,
    title: Row(
      children: [
        Icon(Icons.location_city, color: ColorManger.primaryColor),
        const SizedBox(width: 8),
        Text(
          S.of(context).appTitle,
          style: GoogleFonts.cairo(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    ),
    actions: [
      Padding(
        padding: EdgeInsets.only(right: ScreenUtilsManager.w8),
        child: IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
      ),
    ],
  );
}
