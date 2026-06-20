import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget AddReportAppbar(BuildContext context) => AppBar(
  elevation: 0,
  surfaceTintColor: Colors.transparent,
  systemOverlayStyle: SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
        ? Brightness.light
        : Brightness.dark,
    statusBarBrightness: Theme.of(context).brightness == Brightness.dark
        ? Brightness.dark
        : Brightness.light,
  ),
  leading: IconButton(
    onPressed: () => Navigator.pop(context),
    icon: Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Icon(
        CupertinoIcons.back,
        size: 22.h,
        color: context.palette.kPrimary,
      ),
    ),
  ),
  centerTitle: true,
  toolbarHeight: 70.h,
  scrolledUnderElevation: 0,
  backgroundColor: context.palette.surfaceContainerLowest,
  foregroundColor: context.palette.onSurface,
  title: Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: Text(
      S.of(context).addReport,
      style: GoogleFonts.cairo(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w700,
        fontSize: 18.sp,
      ),
    ),
  ),
);
