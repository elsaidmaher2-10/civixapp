
import 'package:civixapp/core/resource/assetvaluemanger.dart';
import 'package:civixapp/core/resource/colormanager.dart';
import 'package:civixapp/core/resource/screenutilsmaanger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget otpappbar(BuildContext context, Null Function() param1) {
  return AppBar(
    titleSpacing: 3.w,
    title: Text(
      "Cancel",
      style: TextStyle(
        color: ColorManger.kprimary,
        fontFamily: FontFamily.Otama_ep,
      ),
    ),
    backgroundColor: ColorManger.white,
    leadingWidth: 36.w,

    leading: Padding(
      padding: EdgeInsets.only(left: 10.w, bottom: screeutilsManager.h4),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(CupertinoIcons.back, color: ColorManger.kprimary),
      ),
    ),
  );
}
