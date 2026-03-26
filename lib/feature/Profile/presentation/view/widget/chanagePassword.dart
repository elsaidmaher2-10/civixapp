import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Chanagepassword extends StatelessWidget {
  const Chanagepassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.confirmPassword,
          arguments: {"screen": "profile"},
        );
      },
      child: Container(
        padding: EdgeInsets.all(ScreenUtilsManager.w16),
        decoration: BoxDecoration(
          color: ColorManger.kPrimary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lock_outline,
                  color: ColorManger.kPrimary,
                  size: ScreenUtilsManager.s20,
                ),
                SizedBox(width: ScreenUtilsManager.w12),
                Text(
                  S.of(context).changePassword,
                  style: GoogleFonts.outfit(
                    fontSize: ScreenUtilsManager.s14,
                    fontWeight: FontWeight.w600,
                    color: ColorManger.kPrimary,
                  ),
                ),
              ],
            ),
            Icon(
              Directionality.of(context) == TextDirection.rtl
                  ? CupertinoIcons.back
                  : CupertinoIcons.forward,
              color: ColorManger.kPrimary,
              size: ScreenUtilsManager.s20,
            ),
          ],
        ),
      ),
    );
  }
}
