import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/resource/colormanager.dart';
import '../../../../../core/resource/constantmanger.dart';
import '../../../../../core/resource/screenutilsmaanger.dart';

PreferredSizeWidget buildAppBar() {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    backgroundColor: ColorManger.background,
    elevation: 0,
    centerTitle: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.security, color: ColorManger.workerprimary),
        SizedBox(width: ScreenUtilsManager.w4),
        Text(
          Constantmanger.verificationPage,
          style: GoogleFonts.cairo(
            color: ColorManger.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtilsManager.s18,
          ),
        ),
      ],
    ),
  );
}
