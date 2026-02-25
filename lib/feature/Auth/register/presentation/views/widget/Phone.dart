import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:flutter/material.dart';

class Phone extends StatelessWidget {
  Phone({super.key, required this.controller, required this.validator});
  String? Function(String?)? validator;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   Constantmanger.phone,
        //   style: TextStyle(
        //     color: ColorManger.Lightgrey,
        //     fontSize: ScreenUtilsManager.s16,
        //   ),
        // ),
        SizedBox(height: ScreenUtilsManager.h6),
        CustomTextfromfield(
          controller: controller,
          ktype: TextInputType.number,
          prefix: Icon(Icons.phone, color: ColorManger.Lightgrey2),
          hinttext: Constantmanger.phonehint,
          validator: validator,
          lable: Constantmanger.phonehint,
        ),
        SizedBox(height: ScreenUtilsManager.h16),
      ],
    );
  }
}
