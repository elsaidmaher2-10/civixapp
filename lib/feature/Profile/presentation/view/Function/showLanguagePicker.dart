import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showLanguagePicker(context) async {
  await showCupertinoDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: ColorManger.white,
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilsManager.h24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Constantmanger.selectLanguage,
              style: GoogleFonts.inter(
                fontSize: ScreenUtilsManager.s20,
                fontWeight: FontWeight.w600,
                color: ColorManger.kPrimary,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h10),
            Text(
              Constantmanger.choosePreferredLanguage,
              style: GoogleFonts.inter(
                fontSize: ScreenUtilsManager.s12,
                fontWeight: FontWeight.w300,
                color: ColorManger.lightGrey2,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h16),

            GestureDetector(
              onTap: () {
                Navigator.pop(context, "en");
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(ScreenUtilsManager.p10),
                margin: EdgeInsets.symmetric(vertical: ScreenUtilsManager.h6),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: ScreenUtilsManager.w1,
                    color: ColorManger.lightGrey2,
                  ),
                  borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
                ),
                child: Text(
                  Constantmanger.english,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.libertinusSans(
                    fontSize: ScreenUtilsManager.s14,
                    fontWeight: FontWeight.w600,
                    color: ColorManger.textBlack,
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.pop(context, "ar");
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(ScreenUtilsManager.p10),
                margin: EdgeInsets.symmetric(vertical: ScreenUtilsManager.h6),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: ScreenUtilsManager.w1,
                    color: ColorManger.lightGrey2,
                  ),
                  borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
                ),
                child: Text(
                  Constantmanger.arabic,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.libertinusSans(
                    fontSize: ScreenUtilsManager.s14,
                    fontWeight: FontWeight.w600,
                    color: ColorManger.textBlack,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}