import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:citifix/generated/l10n.dart'; // استيراد ملف الترجمة

import '../../../../../core/resource/colormanager.dart';
import '../../../../../core/resource/screenutilsmaanger.dart';

PreferredSizeWidget buildAppBar(BuildContext context) {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    backgroundColor: ColorManger.background,
    elevation: 0,
    leading: IconButton(
      color: ColorManger.workerprimary,
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: ScreenUtilsManager.w4),
        Text(
          S.of(context).verificationTitle,
          style: GoogleFonts.cairo(
            color: ColorManger.workerprimary,
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtilsManager.s18,
          ),
        ),
      ],
    ),
  );
}
