import 'package:citifix/core/function/imagebutton.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
void showSignupImageBottomSheet(BuildContext context) {
  showModalBottomSheet(
    barrierColor: Colors.transparent,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (ctx) => Wrap(
      children: [
        Appbutton(
          onPressed: () async {
            Navigator.pop(ctx);
          },
          text: Constantmanger.photoGallery,
        ),

        Divider(height: 2, color: ColorManger.white, thickness: 2),

        Appbutton(
          onPressed: () async {
            Navigator.pop(ctx);
          },
          text: Constantmanger.camera,
        ),

        SizedBox(height: 10.h),

        Appbutton(
          onPressed: () => Navigator.pop(ctx),
          color: ColorManger.white,
          text: Constantmanger.cancel,
        ),
      ],
    ),
  );
}
