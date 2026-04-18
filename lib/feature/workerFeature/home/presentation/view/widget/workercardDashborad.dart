import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildWorkerCard(
  BuildContext context, {
  required String label,
  required String value,
}) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(ScreenUtilsManager.w20),
      decoration: BoxDecoration(
        color: context.palette.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
        boxShadow: [
          BoxShadow(
            color: context.palette.onSurface.withOpacity(0.04),
            blurRadius: ScreenUtilsManager.s32,
            offset: Offset(ScreenUtilsManager.w0, ScreenUtilsManager.h12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s11,
              fontWeight: FontWeight.bold,
              color: context.palette.onSurfaceVariant,
              letterSpacing: ScreenUtilsManager.s1,
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h4),
          Text(
            value,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
