import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget confirmpassappbar(
  BuildContext context,
  VoidCallback onBack,
) {
  return AppBar(
    centerTitle: true,
    titleSpacing: 3.w,
    title: Text(
      S.of(context).newPassword,
      style: TextStyle(fontSize: 20.sp, color: ColorManger.kPrimary),
    ),
    backgroundColor: ColorManger.white,
    leadingWidth: 36.w,
    leading: Padding(
      padding: EdgeInsetsDirectional.all(ScreenUtilsManager.w8),
      child: IconButton(
        onPressed: onBack,
        icon: Icon(CupertinoIcons.back, color: ColorManger.kPrimary),
      ),
    ),
  );
}
