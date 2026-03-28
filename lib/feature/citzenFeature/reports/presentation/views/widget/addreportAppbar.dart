import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/generated/l10n.dart'; // استيراد ملف الترجمة
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget AddReportAppbar(BuildContext context) => AppBar(
  elevation: 0,

  leading: IconButton(
    onPressed: () => Navigator.pop(context),
    icon: Icon(CupertinoIcons.back, size: 22.h, color: ColorManger.kPrimary),
  ),
  centerTitle: true,
  scrolledUnderElevation: 0,
  backgroundColor: Colors.white,
  title: Text(
    S.of(context).addReport,
    style: TextStyle(
      color: ColorManger.kPrimary,
      fontWeight: FontWeight.w600,
      fontSize: 18.sp,
    ),
  ),
);
