import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:civixapp/core/resource/screenutilsmaanger.dart';
import 'package:civixapp/core/widget/customtextfromfield.dart';
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
        //     fontSize: screeutilsManager.s16,
        //   ),
        // ),
        SizedBox(height: screeutilsManager.h6),
        CustomTextfromfield(
          controller: controller,
          ktype: TextInputType.number,

          hinttext: Constantmanger.phonehint,
          validator: validator,
          lable: Constantmanger.phonehint,
        ),
        SizedBox(height: screeutilsManager.h16),
      ],
    );
  }
}
