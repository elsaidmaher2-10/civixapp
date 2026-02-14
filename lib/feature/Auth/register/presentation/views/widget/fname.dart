
import 'package:civixapp/core/resource/colormanager.dart';
import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:civixapp/core/resource/screenutilsmaanger.dart';
import 'package:civixapp/core/widget/customtextfromfield.dart';
import 'package:flutter/material.dart';

class Fname extends StatelessWidget {
  Fname({super.key, required this.controller, required this.validator});
  TextEditingController controller;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   Constantmanger.fname,
        //   style: TextStyle(
        //     color: ColorManger.Lightgrey,
        //     fontSize: screeutilsManager.s16,
        //   ),
        // ),
        SizedBox(height: screeutilsManager.h6),
        CustomTextfromfield(
          controller: controller,
          hinttext: Constantmanger.fnamehint,
          validator: validator, lable:   Constantmanger.fname,
        ),
        SizedBox(height: screeutilsManager.h16),
      ],
    );
  }
}
