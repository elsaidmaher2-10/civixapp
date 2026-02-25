import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HaveAccountORLogin extends StatelessWidget {
  const HaveAccountORLogin({super.key, required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RichText(
        softWrap: true,

        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "Have an account already?",
              style: TextStyle(color: ColorManger.Lightgrey2, fontSize: 14.sp),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              baseline: TextBaseline.alphabetic,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  splashFactory: NoSplash.splashFactory,
                ),
                onPressed: onPressed,
                child: Text(
                  Constantmanger.logIn,
                  style: TextStyle(color: ColorManger.kprimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
