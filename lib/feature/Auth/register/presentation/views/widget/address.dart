import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:civixapp/core/resource/screenutilsmaanger.dart';
import 'package:civixapp/core/widget/customtextfromfield.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/widget/address.dart';
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
        //     fontSize: screeutilsManager.s16,
        //   ),
        // ),
        SizedBox(height: screeutilsManager.h6),
        CustomTextfromfield(
          onChanged: onChanged,
          controller: controller,
          obstext: false,
          hinttext: Constantmanger.address,
          lable: Constantmanger.Address,
        ),
        SizedBox(height: screeutilsManager.h16),
      ],
    );
  }
}
