import 'package:civixapp/core/resource/colormanager.dart';
import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:civixapp/core/resource/screenutilsmaanger.dart';
import 'package:civixapp/core/widget/customtextfromfield.dart';
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
        //     fontSize: screeutilsManager.s16,
        //   ),
        // ),
        SizedBox(height: screeutilsManager.h6),
        CustomTextfromfield(
          ktype: TextInputType.emailAddress,
          controller: controller,
          hinttext: Constantmanger.hinytextemail,
          validator: validator,
          lable: Constantmanger.email,
        ),
        SizedBox(height: screeutilsManager.h16),
      ],
    );
  }
}
