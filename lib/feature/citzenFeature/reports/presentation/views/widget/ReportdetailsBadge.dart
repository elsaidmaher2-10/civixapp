import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/service/StatusReport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildStatusBadge(String text) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: ScreenUtilsManager.w12,
      vertical: ScreenUtilsManager.h4,
    ),
    decoration: BoxDecoration(
      color: StatusReport.values
          .firstWhere((e) => e.value == text)
          .color
          .withOpacity(0.2),
      borderRadius: BorderRadius.circular(ScreenUtilsManager.r20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        iconStatus(StatusReport.fromString(text)),
        SizedBox(width: ScreenUtilsManager.w4),
        Text(
          text,
          style: GoogleFonts.cairo(
            color: StatusReport.values.firstWhere((e) => e.value == text).color,
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtilsManager.s12,
          ),
        ),
      ],
    ),
  );
}

Widget iconStatus(StatusReport status) {
  switch (status) {
    case StatusReport.pending:
      return SvgPicture.asset(
        AssetValueManager.pending,
        colorFilter: ColorFilter.mode(ColorManger.orange, BlendMode.srcATop),
      );
    case StatusReport.inpprogress:
      return SvgPicture.asset(
        AssetValueManager.active,
        colorFilter: ColorFilter.mode(ColorManger.kPrimary, BlendMode.srcATop),
      );
    case StatusReport.resolved:
      return SvgPicture.asset(
        AssetValueManager.resolved,

        colorFilter: ColorFilter.mode(ColorManger.green, BlendMode.srcATop),
      );
  }
}
