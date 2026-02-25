import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:flutter/material.dart';

class Lname extends StatelessWidget {
  const Lname({super.key, required this.controller, required this.validator});
  final TextEditingController controller;
  final String? Function(String?)? validator;
  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   Constantmanger.lname,
        //   style: TextStyle(
        //     color: ColorManger.Lightgrey,
        //     fontSize: ScreenUtilsManager.s16,
        //   ),
        // ),
        SizedBox(height: ScreenUtilsManager.h6),
        CustomTextfromfield(
          controller: controller,
          prefix: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(AssetValueManager.name, height: 2, width: 2),
          ),
          hinttext: Constantmanger.flnamehint,
          validator: validator,
          lable: Constantmanger.lname,
        ),
        SizedBox(height: ScreenUtilsManager.h16),
      ],
    );
  }
}
