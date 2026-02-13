import 'package:civixapp/core/resource/assetvaluemanger.dart';
import 'package:civixapp/core/resource/colormanager.dart';
import 'package:civixapp/core/resource/screenutilsmaanger.dart';
import 'package:civixapp/core/routing/routes.dart';
import 'package:civixapp/feature/Auth/otpverifcation/presentation/view/widget/otpappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Otpvrificationcode extends StatefulWidget {
  const Otpvrificationcode({super.key});

  @override
  State<Otpvrificationcode> createState() => _OtpvrificationcodeState();
}

class _OtpvrificationcodeState extends State<Otpvrificationcode> {
  final int otpLength = 6;

  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < otpLength - 1) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else {
        FocusScope.of(context).unfocus();
      }
    } else {
      if (index > 0) {
        FocusScope.of(context).requestFocus(focusNodes[index - 1]);
      }
    }
  }

  String getOtpCode() {
    return controllers.map((e) => e.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.white,
      appBar: otpappbar(context, () {}),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screeutilsManager.w18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "OTP Verification",
              style: TextStyle(
                color: ColorManger.kprimary,
                fontSize: 20.sp,
                fontFamily: FontFamily.Otama_ep,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              "we have sent a 6-digit code to your registered  email address/phone number  ",
              style: TextStyle(
                color: ColorManger.Lightgrey2,
                fontSize: 14.sp,
                fontFamily: FontFamily.Otama_ep,
              ),
            ),
            SizedBox(height: 48.h),

            Row(
              children: List.generate(otpLength, (index) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: TextFormField(
                      controller: controllers[index],
                      focusNode: focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      onChanged: (value) => onOtpChanged(value, index),
                      decoration: const InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                );
              }),
            ),

            SizedBox(height: 21.h),

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
                  final otp = getOtpCode();

                  Navigator.of(context).pushNamed(Routes.confirmPassword);
                  print("OTP Code: $otp");
                },
                child: const Text("Confirm"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
