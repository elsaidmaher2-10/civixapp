import 'package:civixapp/core/resource/assetvaluemanger.dart';
import 'package:civixapp/core/resource/colormanager.dart';
import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:civixapp/core/resource/screenutilsmaanger.dart';
import 'package:civixapp/core/widget/customtextfromfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class Nationalnumber extends StatelessWidget {
  Nationalnumber({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  TextEditingController controller;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   Constantmanger.nationalnumber,
        //   style: TextStyle(
        //     color: ColorManger.Lightgrey,
        //     fontSize: screeutilsManager.s16,
        //   ),
        // ),
        SizedBox(height: screeutilsManager.h6),
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
                color: ColorManger.Lightgrey2,
                AssetValueManager.id,
              ),
            ),
          ),

          validator: (value) {
            if (value == null || value.isEmpty) {
              return Constantmanger.hintnationalnumber;
            }
            if (value.length != 14) {
              return "National ID must be exactly 14 digits";
            }
            if (!RegExp(r'^\d{14}$').hasMatch(value)) {
              return "National ID must contain only digits";
            }
            return null; // تمام
          },

          onChanged: onChanged,
          controller: controller,
          obstext: false,
          ktype: TextInputType.number,
          hinttext: Constantmanger.nationalnumber,
          lable: Constantmanger.nationalnumber,
        ),
        SizedBox(height: screeutilsManager.h16),
      ],
    );
  }
}
