import 'package:civixapp/core/resource/assetvaluemanger.dart';
import 'package:civixapp/core/resource/colormanager.dart' show ColorManger;
import 'package:civixapp/core/resource/screenutilsmaanger.dart';
import 'package:civixapp/core/routing/routes.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/widget/Email.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Foregetpassword extends StatelessWidget {
  const Foregetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.white,
      appBar: foregetpasswordappbar(context),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screeutilsManager.w18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forget Your Password ?",
              style: TextStyle(
                color: ColorManger.kprimary,
                fontSize: 20.sp,
                fontFamily: FontFamily.Otama_ep,
              ),
            ),
            SizedBox(height: 6.h),
            RichText(
              text: TextSpan(
                text:
                    "Please enter the email address associated with your account, and we'll send you OTP to reset your password.",
                style: TextStyle(
                  color: ColorManger.Lightgrey2,
                  fontSize: screeutilsManager.s14,
                ),
              ),
            ),
            SizedBox(height: 58.h),

            Email(
              controller: TextEditingController(),
              validator: (String? p1) {},
            ),
            SizedBox(height: 151.h),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManger.kprimary,
                  foregroundColor: ColorManger.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screeutilsManager.r10),
                  ),
                ),
                onPressed: () {
                  print("object");
                  Navigator.of(context).pushNamed(Routes.otpverficationc);
                },
                child: Text("Send  Code"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

PreferredSizeWidget foregetpasswordappbar(BuildContext context) {
  return AppBar(
    titleSpacing: 3.w,
    title: Text(
      "Back",
      style: TextStyle(
        color: ColorManger.kprimary,
        fontFamily: FontFamily.Otama_ep,
      ),
    ),
    backgroundColor: ColorManger.white,
    leadingWidth: 36.w,

    leading: Padding(
      padding: EdgeInsets.only(left: 10.w, bottom: screeutilsManager.h4),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(CupertinoIcons.back, color: ColorManger.kprimary),
      ),
    ),
  );
}
