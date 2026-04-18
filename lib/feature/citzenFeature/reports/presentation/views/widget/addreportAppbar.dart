import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/generated/l10n.dart'; 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget AddReportAppbar(BuildContext context) => AppBar(
  elevation: 0,
  surfaceTintColor: Colors.transparent,
  leading: IconButton(
    onPressed: () => Navigator.pop(context),
    icon: Icon(CupertinoIcons.back, size: 22.h, color: context.palette.kPrimary),
  ),
  centerTitle: true,
  scrolledUnderElevation: 0,
  backgroundColor: context.palette.surfaceContainerLowest,
  foregroundColor: context.palette.onSurface,
  title: Text(
    S.of(context).addReport,
    style: GoogleFonts.cairo(
      color: context.palette.onSurface,
      fontWeight: FontWeight.w600,
      fontSize: 18.sp,
    ),
  ),
);
