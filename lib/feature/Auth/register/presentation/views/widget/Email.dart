import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';

class Email extends StatelessWidget {
  const Email({super.key, required this.controller, required this.validator});
  final TextEditingController controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   Constantmanger.email,
        //   style: GoogleFonts.cairo(
        //     color: ColorManger.lightGrey,
        //     fontSize: ScreenUtilsManager.s16,
        //   ),
        // ),
        SizedBox(height: ScreenUtilsManager.h6),
        CustomTextfromfield(
          prefix: Icon(Icons.email, color: ColorManger.lightGrey2),
          ktype: TextInputType.emailAddress,
          controller: controller,
          hinttext: S.of(context).hintEmail,
          validator: validator,
          lable: S.of(context).email,
        ),
        SizedBox(height: ScreenUtilsManager.h16),
      ],
    );
  }
}
