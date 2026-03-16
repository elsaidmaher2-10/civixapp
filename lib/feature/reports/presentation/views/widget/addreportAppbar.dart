import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget AddReportAppbar(context) => AppBar(
  elevation: 0,
  leading: IconButton(
    onPressed: () => Navigator.pop(context),
    icon: Icon(CupertinoIcons.back, size: 25.h, color: ColorManger.kprimary),
  ),
  centerTitle: true,
  scrolledUnderElevation: 0,
  backgroundColor: Colors.white,
  title: Text(
    Constantmanger.addreport,
    style: TextStyle(color: ColorManger.kprimary, fontWeight: FontWeight.w600),
  ),
);
