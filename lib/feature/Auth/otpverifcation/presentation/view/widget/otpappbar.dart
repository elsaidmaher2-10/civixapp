import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget otpappbar(BuildContext context, Null Function() param1) {
  return AppBar(
    centerTitle: true,
    titleSpacing: 3.w,
    title: Text(
      S.of(context).otpVerification,
      style: TextStyle(color: ColorManger.kPrimary, fontSize: 20.sp),
    ),
    backgroundColor: ColorManger.white,
    leadingWidth: 36.w,

    leading: Padding(
      padding: EdgeInsets.only(left: 10.w, bottom: ScreenUtilsManager.h4),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(CupertinoIcons.back, color: ColorManger.kPrimary),
      ),
    ),
  );
}
