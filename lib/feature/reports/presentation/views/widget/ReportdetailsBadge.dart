import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/service/StatusReport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          style: TextStyle(
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
    case StatusReport.active:
      return SvgPicture.asset(
        AssetValueManager.active,
        colorFilter: ColorFilter.mode(ColorManger.kprimary, BlendMode.srcATop),
      );
    case StatusReport.resolved:
      return SvgPicture.asset(
        AssetValueManager.resolved,

        colorFilter: ColorFilter.mode(ColorManger.green, BlendMode.srcATop),
      );
    case StatusReport.rejected:
      return Icon(Icons.cancel, color: ColorManger.white);
  }
}
