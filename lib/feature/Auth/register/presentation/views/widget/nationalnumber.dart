import 'package:citifix/core/function/sinupvalidator.dart';
import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Nationalnumber extends StatelessWidget {
  const Nationalnumber({super.key, required this.controller});

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   Constantmanger.nationalnumber,
        //   style: TextStyle(
        //     color: ColorManger.lightGrey,
        //     fontSize: ScreenUtilsManager.s16,
        //   ),
        // ),
        SizedBox(height: ScreenUtilsManager.h6),
        CustomTextfromfield(
          prefix: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 2,
              width: 2,
              child: SvgPicture.asset(
                fit: BoxFit.cover,
                height: 1,
                width: 1,
                color: ColorManger.lightGrey2,
                AssetValueManager.id,
              ),
            ),
          ),

          validator: (value) => nationalIdValidator(context, value),

          controller: controller,
          obstext: false,
          ktype: TextInputType.number,
          hinttext: S.of(context).hintNationalNumber,
          lable: S.of(context).nationalNumber,
        ),
        SizedBox(height: ScreenUtilsManager.h16),
      ],
    );
  }
}
