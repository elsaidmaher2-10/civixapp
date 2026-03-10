import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/home/presentation/view/widget/ProfileMenu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Padding ProfileSettings() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w32),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Constantmanger.settings,
          style: GoogleFonts.inter(
            letterSpacing: 1.6,
            color: ColorManger.Lightgrey6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: ScreenUtilsManager.h16),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ProfileMenuItem(
                  iconPath: AssetValueManager.language,
                  title: Constantmanger.language,
                  onTap: () {},
                ),
                ProfileMenuItem(
                  iconPath: AssetValueManager.identity,
                  title: Constantmanger.identity,
                ),
                ProfileMenuItem(
                  iconPath: AssetValueManager.support,
                  title: Constantmanger.support,
                ),
                ProfileMenuItem(
                  iconPath: AssetValueManager.accountinformation,
                  title: Constantmanger.accouninormation,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
