import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Address extends StatelessWidget {
  Address({super.key, required this.controller, required this.onChanged});

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
        //     fontSize: ScreenUtilsManager.s16,
        //   ),
        // ),
        SizedBox(height: ScreenUtilsManager.h6),
        CustomTextfromfield(
          prefix: Icon(Icons.location_city, color: ColorManger.Lightgrey2),
          onChanged: onChanged,
          controller: controller,
          obstext: false,
          hinttext: Constantmanger.address,
          lable: Constantmanger.Address,
        ),
        SizedBox(height: ScreenUtilsManager.h16),
      ],
    );
  }
}
