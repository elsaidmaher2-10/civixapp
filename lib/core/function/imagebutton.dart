import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.icon,
    this.isLoading = false,
    this.height = 56.0,
  });

  final VoidCallback? onPressed;
  final String text;
  final Color? backgroundColor;
  final Color textColor;
  final IconData? icon;
  final bool isLoading;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          backgroundColor: backgroundColor ?? context.palette.workerprimary,
          foregroundColor: textColor,
          elevation: 2,
          disabledBackgroundColor: Colors.grey.shade300,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                height: 24.h,
                width: 24.h,
                child: CircularProgressIndicator(
                  color: textColor,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 24.sp, color: textColor),
                    SizedBox(width: 8.w),
                  ],
                  Text(
                    text,
                    style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.lable,
    super.key,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.raduis = 8,
  });

  final double raduis;
  final void Function()? onPressed;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? context.palette.kPrimary,
          foregroundColor: foregroundColor ?? context.palette.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(raduis),
          ),
        ),
        onPressed: onPressed,
        icon: icon,
        label: Text(
          lable,
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
