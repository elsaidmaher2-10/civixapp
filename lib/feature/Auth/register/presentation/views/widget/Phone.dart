import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';

class Phone extends StatelessWidget {
  const Phone({super.key, required this.controller, required this.validator});
  final String? Function(String?)? validator;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   Constantmanger.phone,
        //   style: TextStyle(
        //     color: ColorManger.lightGrey,
        //     fontSize: ScreenUtilsManager.s16,
        //   ),
        // ),
        SizedBox(height: ScreenUtilsManager.h6),
        CustomTextfromfield(
          controller: controller,
          ktype: TextInputType.number,
          prefix: Icon(Icons.phone, color: ColorManger.lightGrey2),
          hinttext: S.of(context).hintPhone,
          validator: validator,
          lable: S.of(context).phone,
        ),
        SizedBox(height: ScreenUtilsManager.h16),
      ],
    );
  }
}
