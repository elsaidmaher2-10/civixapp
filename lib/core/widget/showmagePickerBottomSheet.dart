import 'package:citifix/core/function/imagebutton.dart' hide AppButton;
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'customButton.dart';

void showSignupImageBottomSheet(BuildContext context) {
  showModalBottomSheet(
    barrierColor: Colors.transparent,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (ctx) => Wrap(
      children: [
        AppButton(
          onPressed: () async {
            Navigator.pop(ctx);
          },
          text: Constantmanger.photoGallery,
        ),

        Divider(height: 2, color: ColorManger.white, thickness: 2),

        AppButton(
          onPressed: () async {
            Navigator.pop(ctx);
          },
          text: Constantmanger.camera,
        ),

        SizedBox(height: 10.h),

        AppButton(
          onPressed: () => Navigator.pop(ctx),
          text: Constantmanger.cancel,
        ),
      ],
    ),
  );
}
