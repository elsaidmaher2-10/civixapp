import 'dart:developer';

import 'package:civixapp/core/resource/colormanager.dart' show ColorManger;
import 'package:civixapp/core/resource/screenutilsmaanger.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/widget/Email.dart';
import 'package:dio/dio.dart';
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
                onPressed: () async {
                  Dio dio = Dio();

                  try {
                    final response = await dio.post(
                      "https://citifix.runasp.net/api/Account/confirm-email-login",
                      // options: Options(
                      //   // contentType: Headers.jsonContentType,
                      //   // headers: {"Accept": "application/json"},
                      // ),
                      data: {
                        // "nationalId": "30005281149567",
                        // "fullName": " الحج محمود وليد",
                        "email": "elsaidmaher@students.du.edu.eg",
                        // "phoneNumber": "01234567890",
                        // "password": "Aa123456#",
                        // "address": "Cairo",
                        // "dateOfBirth": "2000-05-10",
                        // "role": "WORKER",
                        "code": "111111111",
                      },
                    );

                    print("response" + response.data.toString());
                  } catch (e) {
                    if (e is DioException) {
                      print("STATUS = ${e.response?.statusCode}");
                      print("DATA = ${e.response?.data}");
                    } else {
                      print(e.toString());
                    }
                  }
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
    centerTitle: true,
    title: Text(
      "Forget Password",
      style: TextStyle(
        color: ColorManger.kprimary,
        fontSize: 20.sp,
        // fontFamily: FontFamily.Otama_ep,
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
