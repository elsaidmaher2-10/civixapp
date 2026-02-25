import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:flutter/material.dart';

class Email extends StatelessWidget {
  Email({super.key, required this.controller, required this.validator});
  TextEditingController controller;
  String? Function(String?)? validator;
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   Constantmanger.email,
        //   style: TextStyle(
        //     color: ColorManger.Lightgrey,
        //     fontSize: ScreenUtilsManager.s16,
        //   ),
        // ),
        SizedBox(height: ScreenUtilsManager.h6),
        CustomTextfromfield(
          prefix: Icon(Icons.email, color: ColorManger.Lightgrey2),
          ktype: TextInputType.emailAddress,
          controller: controller,
          hinttext: Constantmanger.hinytextemail,
          validator: validator,
          lable: Constantmanger.email,
        ),
        SizedBox(height: ScreenUtilsManager.h16),
      ],
    );
  }
}
