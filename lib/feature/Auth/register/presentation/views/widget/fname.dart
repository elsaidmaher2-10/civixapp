import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:flutter/material.dart';

class Fname extends StatelessWidget {
  const Fname({super.key, required this.controller, required this.validator});
  final TextEditingController controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   Constantmanger.fname,
        //   style: TextStyle(
        //     color: ColorManger.Lightgrey,
        //     fontSize: ScreenUtilsManager.s16,
        //   ),
        // ),
        SizedBox(height: ScreenUtilsManager.h6),
        CustomTextfromfield(
          prefix: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(AssetValueManager.name2, height: 2, width: 2),
          ),
          controller: controller,
          hinttext: Constantmanger.fnamehint,
          validator: validator,
          lable: Constantmanger.fname,
        ),
        SizedBox(height: ScreenUtilsManager.h16),
      ],
    );
  }
}
