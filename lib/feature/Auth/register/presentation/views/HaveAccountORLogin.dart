import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HaveAccountOrLogin extends StatelessWidget {
  const HaveAccountOrLogin({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).haveAccount,
            style: GoogleFonts.cairo(
              color: ColorManger.lightGrey2,
              fontSize: 14.sp,
            ),
          ),

          SizedBox(width: 4.w),
          GestureDetector(
            onTap: onPressed,
            child: Text(
              S.of(context).login,
              style: GoogleFonts.cairo(
                color: ColorManger.kPrimary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
