import 'dart:async';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Saveeditprofile extends StatelessWidget {
  Saveeditprofile({
    required this.role,
    super.key,
    required this.ontap,
    required this.bntcontroller,
  });

  bool role;

  final Function() ontap;
  final StreamController<bool> bntcontroller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.p23),
      child: SizedBox(
        width: double.infinity,
        child: StreamBuilder<bool>(
          initialData: false,
          stream: bntcontroller.stream,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            final bool isEnabled = snapshot.data ?? false;

            return ElevatedButton(
              onPressed: isEnabled ? ontap : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: role
                    ? ColorManger.workerprimary
                    : ColorManger.kPrimary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: ScreenUtilsManager.h16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenUtilsManager.r14),
                ),
                elevation: isEnabled ? 6 : 0,
                shadowColor: role
                    ? ColorManger.workerprimary.withOpacity(0.35)
                    : ColorManger.kPrimary.withOpacity(0.35),
              ),
              child: Text(
                S.of(context).saveChanges,
                style: GoogleFonts.cairo(
                  fontSize: ScreenUtilsManager.s16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
