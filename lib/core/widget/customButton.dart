import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Appbutton extends StatelessWidget {
  const Appbutton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color = const Color(0xffD8D8D8),
  });
  final void Function()? onPressed;

  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(0),
          ),
          backgroundColor: color,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: ColorManger.kprimary, fontSize: 18.sp),
        ),
      ),
    );
  }
}
